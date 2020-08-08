//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityInputField.delegate=self
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        cityInputField.endEditing(true)
//        print(cityInputField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityInputField.endEditing(true)
//        print(cityInputField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if cityInputField.text != ""{
            return true
        }
        else{
            cityInputField.placeholder="Enter a city to Search"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(cityInputField.text!)
        textField.text=""
    }
    
}

