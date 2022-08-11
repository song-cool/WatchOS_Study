//
//  WeatherResponse.swift
//  WatchWeather WatchKit Extension
//
//  Created by 송시원 on 2022/08/10.
//

import Foundation

struct WeatherResponse: Codable {
    var forecast: [WeatherModel]
}
