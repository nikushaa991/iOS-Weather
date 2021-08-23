//
//  AddCityDelegate.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/7/21.
//

import Foundation

protocol AddCityDelegate: class {
    func handle(today: TodayEntity)
}
