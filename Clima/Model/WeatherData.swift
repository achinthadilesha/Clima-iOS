//
//  WeatherData.swift
//  Clima
//
//  Created by Achintha Dilesha on 8/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData:Codable {
    var name:String
    let main:Main
    let weather:[Weather]
    let sys:Country
}


struct Main:Codable{
    let temp:Double
}

struct Weather:Codable {
    let description:String
    let id:Int
}


struct Country:Codable{
    let country:String
}
