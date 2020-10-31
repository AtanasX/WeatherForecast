//
//  PlaceCell.swift
//  WeatherForecast
//
//  Created by Atanas Nachkov on 31.10.20.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func setPlace(place: Places) {
        placeLabel.text = place.name
        temperatureLabel.text = String(place.temperature)
    }
    
}
