//
//  SecondViewController.swift
//  WeatherForecast
//
//  Created by Atanas Nachkov on 31.10.20.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController, CLLocationManagerDelegate {
    
    var locManager = CLLocationManager()
   // locManager.requestWhenInUseAuthorization()
    
    let errorAlert = UIAlertController(title: "Error", message: "There was an unexpected error", preferredStyle: .alert)
    let noPlaceAlert = UIAlertController(title: "No place found", message: "No such place could be found. Try another one.", preferredStyle: .alert)

    
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func getLocationTapped(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        locationManager = CLLocationManager()
//        locationManager?.delegate = self
//        locationManager?.requestAlwaysAuthorization()
        
        var currentLocation: CLLocation!

        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager.location
        }

    }
    
    
    func getData(lat: String, lon: String) {
        
        let apiKey = "111097ee12091c1d539a14fa2f09686c"
        
        guard let url = URL(string: "api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)") else {
            self.errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(self.errorAlert, animated: true)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    self.errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(self.errorAlert, animated: true)
                }
                
                return
            }
            
            var result: API?
            do {
                result = try JSONDecoder().decode(API.self, from: data!)
                
            } catch {
                DispatchQueue.main.async {
                    self.noPlaceAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(self.noPlaceAlert, animated: true)
                }
                
            }
            
            if let result = result {
                DispatchQueue.main.async {
                    
                    self.label.text = "Nearby you is: \(result.main.temp - 262.15) C"
//                    let newItem = Place(name: place, temperature: result.main.temp - 262.15)
//
//                    self.placeToAdd = newItem
//
//                    self.message.text = "In \(place) now is: \(result.main.temp - 262.15) C"
                    
                    
                }

                
            }
            
        }.resume()
        
    }
    

   

}
