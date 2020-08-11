import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityInputField: UITextField!
    
    // initialzing the WeatherManager
    var weatherManager=WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityInputField.delegate=self
    }
    
    // what happens when the search button is pressed
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        cityInputField.endEditing(true)
    }
    
    // what happens when the return/go button pressed on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityInputField.endEditing(true)
        return true
    }
    
    // what heppens after the typing is finished on the text field (validation)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if cityInputField.text != ""{
            return true
        }
        else{
            cityInputField.placeholder="Enter a city to Search"
            return false
        }
    }
    
    // what happens after validation of the textfield
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherManager.printWeatherData(cityName: cityInputField.text!)
        
        // setting the text field value back to an empty field
        textField.text=""
    }
    
}

