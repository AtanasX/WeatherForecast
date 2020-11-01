//
//  SearchViewController.swift
//  WeatherForecast
//
//  Created by Atanas Nachkov on 1.11.20.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    func searchViewController(_ controller: SearchViewController, didFinishAddingPlace place: Place)
    func searchViewControllerDidCancel(_ controller: SearchViewController)
}

class SearchViewController: UIViewController {
    
    var placeToAdd: Place?
    
    weak var delegate: SearchViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func cancelTapped(_ sender: Any) {
        delegate?.searchViewControllerDidCancel(self)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        
        if self.placeToAdd != nil {
            delegate?.searchViewController(self, didFinishAddingPlace: self.placeToAdd!)
        } else {
            print("no place to add")
        }
        
        
    }
    
    let errorAlert = UIAlertController(title: "Error", message: "There was an unexpected error", preferredStyle: .alert)
    let noPlaceAlert = UIAlertController(title: "No place found", message: "No such place could be found. Try another one.", preferredStyle: .alert)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.delegate = self
        
        textField.becomeFirstResponder()
    }
    
    func getData(place: String) {
        
        let apiKey = "111097ee12091c1d539a14fa2f09686c"
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(place)&appid=\(apiKey)") else {
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
                    let newItem = Place(name: place, temperature: result.main.temp - 262.15)
                    
                    self.placeToAdd = newItem
                    
                    self.message.text = "In \(place) now is: \(result.main.temp - 262.15) C"
                    
                    
                }

                
            }
            
        }.resume()
        
    }

}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()
        
        if let text = textField.text {
            getData(place: text)
        }
        
        return true
    }
}
