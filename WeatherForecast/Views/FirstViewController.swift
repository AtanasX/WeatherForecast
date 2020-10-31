//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Atanas Nachkov on 30.10.20.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    @IBAction func refreshTable(_ sender: Any) {
        
        let place = "London"
        
        let newPlace = Places(name: place, temperature: NetworkManager.shared.getData(place: place).temperature)
        
        data.append(newPlace)
        
        tableView.reloadData()
        
    }
    
    var data: [Places] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //data.append(Places(name: "Sofia", temperature: 13.00))
    }


}

extension FirstViewController: UITableViewDelegate {
    
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceCell
        
        cell.setPlace(place: data[indexPath.row])
        
        return cell
    }
    
    
}
