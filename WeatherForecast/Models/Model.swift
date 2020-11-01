//
//  Model.swift
//  WeatherForecast
//
//  Created by Atanas Nachkov on 31.10.20.
//

import Foundation

struct Place {
    var name: String
    var temperature: Double
    var temperatureF: Double {
        return (temperature * 5/9) + 32
    }
    
    init(name: String, temperature: Double) {
        self.name = name
        self.temperature = temperature
    }
}

struct API: Codable {
    var main: Info
    
}

struct Info: Codable {
    var temp: Double
}
