//
//  WeatherConditions.swift
//  Model que representam os dados retornados do serviço Dark sky
//
//  Created by Paulo H. Machtura on 15/02/20.
//

import UIKit

struct WeatherConditions :Codable {
    let currently : CurrentWeather?
    let hourly : WeatherList?
    let daily : WeatherList?
}

struct CurrentWeather : Codable {
    let time : Double
    let summary: String
    let icon : String
    let precipIntensity : Double?
    let precipProbability : Double?
    let precipType : String?
    let temperature : Double?
    let apparentTemperature : Double?
    let dewPoint : Double?
    let humidity : Double?
    let pressure : Double?
    let windSpeed : Double?
    let windGust : Double?
    let windBearing: Double?
    let cloudCover: Double?
    let uvIndex : Double?
    let visibility : Double?
    let ozone : Double?
    let apparentTemperatureMax : Double?
}


struct WeatherList : Codable {
    var summary : String
    var icon : String
    let data : [CurrentWeather]
}

