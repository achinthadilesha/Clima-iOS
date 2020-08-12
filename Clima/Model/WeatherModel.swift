//
//  WeatherModel.swift
//  Clima
//
//  Created by Achintha Dilesha on 8/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    
    let cityName:String
    let temperature:Double
    let conditionID:Int
    
    func getConditionName(weatherID:Int)->String{
        switch weatherID {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "snow"
        case 700...781:
            return "wind"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "exclamationmark.icloud"
        }
    }
    
}
