//
//  ApiService.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

typealias ApiServiceResponseHandler<T: Decodable> = (Result<ApiServiceResponse<T>, Error>) -> Void
typealias ApiServiceRawDataResponseHandler = (Result<Data, Error>) -> Void

protocol ApiService {
    func startRequest<T: Decodable>(request: ApiServiceRequest, completion: @escaping ApiServiceResponseHandler<T>)
    func startRawDataRequest(request: ApiServiceRequest, completion: @escaping ApiServiceRawDataResponseHandler)
}

class DefaultApiService: ApiService {

    // MARK: Singleton Shared Instance with default configuration

    static let defaultShared: ApiService = DefaultApiService(with: .default)

    let session: URLSession

    private init(with configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
    }

    func startRequest<T: Decodable>(request: ApiServiceRequest, completion: @escaping ApiServiceResponseHandler<T>) {

        startRawDataRequest(request: request) { (result) in

            switch result {
            case .success(let data):

                let entity: T
                do { entity = try JSONDecoder().decode(T.self, from: data) }
                catch let error {
                    completion(.failure(error))
                    return
                }

                let response = ApiServiceResponse(entity: entity)

                completion(.success(response))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func startRawDataRequest(request: ApiServiceRequest, completion: @escaping ApiServiceRawDataResponseHandler) {

        guard let request = request.urlRequest
        else {
            completion(.failure(CoreError(message: "Can not create request")))
            return
        }

        session.dataTask(with: request) { (data, response, error) in

            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse
            else {
                completion(.failure(CoreError(message: "Application did not get requested data")))
                return
            }

            let statusCode = httpResponse.statusCode
            guard (200 ..< 300) ~= statusCode
            else {
                completion(.failure(CoreError(message: "Http error occured with error code \(statusCode)")))
                return
            }

            completion(.success(data))

        }.resume()
    }
}
