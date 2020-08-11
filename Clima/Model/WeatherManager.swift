//
//  WeatherManager.swift
//  Clima
//
//  Created by Achintha Dilesha on 8/9/20.
//

import Foundation

struct WeatherManager{
    let weather="https://api.openweathermap.org/data/2.5/weather?units=metric&appid=20af37f2066cbe51701c96292966adee"
    
    var weatherModel=WeatherModel()
    
    func printWeatherData(cityName:String){
        let weatherURL="\(weather)&q=\(cityName)"
        
        performRequest(urlString: weatherURL)
        
        //        print(weatherURL)
    }
    
    //session handling for URL
    func performRequest(urlString:String){
        // creating the URL
        if let url=URL(string: urlString){
            // session creation
            let session=URLSession(configuration: .default)
            
            // give the session a task
            let task=session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData=data{
                    //                    let dataString=String(data: safeData, encoding: .utf8)
                    //                    print(dataString!)
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            // start the task
            task.resume()
            
        }
    }
    
    func parseJSON(weatherData:Data){
        let decoder=JSONDecoder()
        do{
            let decoderData=try decoder.decode(WeatherData.self, from: weatherData)
            print(decoderData.name)
            print(decoderData.main.temp)
            // let tempID=getConditionName(weatherID: decoderData.weather[0].id)
            let tempID=weatherModel.getConditionName(weatherID: decoderData.weather[0].id)
            print(tempID)
            print(decoderData.sys.country)
        }
        catch{
            print(error)
        }
    }
}
