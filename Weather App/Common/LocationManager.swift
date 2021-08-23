//
//  LocationManager.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/1/21.
//

import CoreLocation

protocol LocationManager {
    typealias LocationHandler = (Result<(Double, Double), Error>) -> Void
    func location(completion: @escaping LocationHandler)
}

class DefaultLocationManager: NSObject {

    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()

    private var _completion: LocationHandler? = nil

    private func push(completion: LocationHandler?) {
        _completion = completion
    }

    private func pop() -> LocationHandler? {
        let completion = _completion
        _completion = nil
        return completion
    }
}

extension DefaultLocationManager: LocationManager {

    func location(completion: @escaping LocationHandler) {

        // update completion for later call
        push(completion: completion)

        let locationStatus = locationManager.authorizationStatus

        switch locationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.requestLocation()
                break
            default:
                let completion = pop()
                completion?(.failure(CoreError(message: "Undefined location status")))
        }
    }
}

extension DefaultLocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if let completion = pop() {
            location(completion: completion)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let completion = pop()

        if let latitude = locations.last?.coordinate.latitude,
           let longitude = locations.last?.coordinate.longitude
        {
            completion?(.success((latitude, longitude)))
        } else {
            completion?(.failure(CoreError(message: "Undefined location")))
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let completion = pop()
        completion?(.failure(error))
    }
}
