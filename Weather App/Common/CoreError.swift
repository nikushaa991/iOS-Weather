//
//  CoreError.swift
//  Weather App
//
//  Created by Nika Nasaridze on 1/30/21.
//

import Foundation

struct CoreError: LocalizedError {
    var errorDescription: String? { message }
    var message = ""
}
