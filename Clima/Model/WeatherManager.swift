//
//  WeatherManager.swift
//  Clima
//
//  Created by Achintha Dilesha on 8/9/20.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager, weather: WeatherModel)
    func didFailWithError(error:Error)
}

struct WeatherManager{
    // api URL without the city name
    let weather="https://api.openweathermap.org/data/2.5/weather?units=metric&appid=20af37f2066cbe51701c96292966adee"
    
    // function to set the city name for the URL using the UITextFields as the argument
    func printWeatherData(cityName:String){
        let weatherURL="\(weather)&q=\(cityName)"
        performRequest(weatherURL)
    }
    
    func printWeatherData(latitude:CLLocationDegrees, longitude:CLLocationDegrees){
        let weatherURL="\(weather)&lon=\(longitude)&lat=\(latitude)"
        performRequest(weatherURL)
    }
    
    
    var delegate:WeatherManagerDelegate?
    
    //session handling for URL
    func performRequest(_ urlString:String){
        // creating the URL
        if let url=URL(string: urlString){
            // session creation
            let session=URLSession(configuration: .default)
            
            // give the session a task
            let task=session.dataTask(with: url) { (data, response, error) in
                // if there is an error stop the program and print the error
                if error != nil{
                    self.delegate?.didFailWithError(error:error!)
                    return
                }
                
                // if there is some data catch it
                if let safeData=data{
                    // passing the data to format in JSON format
                    if let weather=self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather:weather)
                    }
                }
            }
             
            // start the task
            task.resume()
            
        }
    }
    
    // format the data in JSON format
    func parseJSON(_ weatherData:Data)->WeatherModel?{
        let decoder=JSONDecoder()
        do{
            
            let decoderData=try decoder.decode(WeatherData.self, from: weatherData)
            
            let cityName=decoderData.name
            let temperature=decoderData.main.temp
            let tempID=decoderData.weather[0].id
            
            let weatherModel=WeatherModel(cityName: cityName, temperature: temperature, conditionID: tempID)
        
//            print(weatherModel.conditionName)
//            print(weatherModel.temperatureString)
            
            return weatherModel
        }
        catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
