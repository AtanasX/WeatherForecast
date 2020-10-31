//
//  Networking.swift
//  WeatherForecast
//
//  Created by Atanas Nachkov on 31.10.20.
//

import Foundation

let apiKey = "111097ee12091c1d539a14fa2f09686c"

class NetworkManager {
    static var shared = NetworkManager()
    
    func getData(place: String) -> Places {
        
        var output: Places = Places(name: place, temperature: 0)
        
        URLSession.shared.dataTask(with: URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(place)&appid=\(apiKey)")!) { (data, response, error) in
            
            guard error == nil else {
                print(error!)
                return
            }
            
            var result: API?
            do {
                result = try JSONDecoder().decode(API.self, from: data!)
                
            } catch {
                print(error)
            }
            
            if let result = result {
                output.temperature = result.main.temp - 262.15
            }
            
        }.resume()
        return output
    }
    
    
}
