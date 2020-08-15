import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityInputField: UITextField!
    
    // initialzing the WeatherManager
    var weatherManager=WeatherManager()
    // corelocation
    let locationManager=CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityInputField.delegate=self
        weatherManager.delegate=self
        locationManager.delegate=self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate{
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
    //        cityLabel.text=(cityInputField.text!)
            // setting the text field value back to an empty field
            textField.text=""
        }
        
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController:WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager:WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text=String(weather.temperatureString)
            self.conditionImageView.image=UIImage(systemName: weather.conditionName)
            self.cityLabel.text=weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


//MARK: - CLLocationDelegate

extension WeatherViewController:CLLocationManagerDelegate{
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location=locations.last{
            locationManager.stopUpdatingLocation()
            let lat=location.coordinate.latitude
            let lon=location.coordinate.longitude
            
            weatherManager.printWeatherData(latitude:lat, longitude:lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
