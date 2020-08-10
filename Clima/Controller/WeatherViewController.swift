import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityInputField: UITextField!
    
    
    var weatherManager=WeatherManager()
    
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
//        print(cityInputField.text!)
        weatherManager.printWeatherData(cityName: cityInputField.text!)
        
        textField.text=""
    }
    
}

