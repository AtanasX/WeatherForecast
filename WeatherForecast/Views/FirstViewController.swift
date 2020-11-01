//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Atanas Nachkov on 30.10.20.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [Place] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addPlace", let destination = segue.destination as? SearchViewController {
            destination.delegate = self
        }
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

extension FirstViewController: SearchViewControllerDelegate {
    func searchViewController(_ controller: SearchViewController, didFinishAddingPlace place: Place) {
        
        self.data.append(place)
        tableView.reloadData()
        
        navigationController?.popViewController(animated: true)
    }
    
    func searchViewControllerDidCancel(_ controller: SearchViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension FirstViewController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool) {
        
        
    }
}
