//
//  CityTempature.swift
//  WeatherApp
//
//  Created by Bhushan Abhyankar on 03/05/17.
//  Copyright © 2017 Bhushan Abhyankar. All rights reserved.
//

import UIKit
class CityClimateMainBO: NSObject {
    
    // BO Members
    var cityTempObj = CityTempature()
    var cityWeatherObj = CityWeather()
    
    /*Intialise object with dictionary*/
    class func initWithDictionary(response : NSDictionary) -> CityClimateMainBO
    {
        // Create new BO object and init it with dictionary values
        let cityWeatherBO = CityClimateMainBO()
        let cityTempature = CityTempature()
        let cityWeather = CityWeather()
        cityWeatherBO.cityTempObj = cityTempature.initWithDictionary(responseDictionary: response["main"] as! NSDictionary)
        let watherArray = response["weather"] as! NSArray

        cityWeatherBO.cityWeatherObj = cityWeather.initWithDictionary(responseDictionary: (watherArray[0] as! NSDictionary))
        return cityWeatherBO
    }
    
}
class CityTempature: NSObject {
   
    // BO Members
    var cityName = String()
     var cityTempValue: NSNumber = 0.0
    var humidity : NSNumber = 0.0
    var temp_min : NSNumber = 0.0
    var temp_max : NSNumber = 0.0
    var pressure : NSNumber = 0.0
    
    // BO Members
    var date = String()
    
    /*Intialise object with dictionary*/
     func initWithDictionary(responseDictionary : NSDictionary) -> CityTempature
    {
        // Create new BO object and init it with dictionary values
        let weatherBO = CityTempature()
      //  weatherBO.date = responseDictionary["dt_txt"] as! String
      //  weatherBO.cityName = responseDictionary["dt_txt"] as! String
        weatherBO.cityTempValue = responseDictionary["temp"] as! NSNumber
        weatherBO.humidity = responseDictionary["humidity"] as! NSNumber
        weatherBO.temp_max = responseDictionary["temp_max"] as! NSNumber
        weatherBO.temp_min = responseDictionary["temp_min"] as! NSNumber
        weatherBO.pressure = responseDictionary["pressure"] as! NSNumber

        return weatherBO
    }

}

class CityWeather: NSObject {
    
    // BO Members
    var cityWeatherdescription = String()
    
    /*Intialise object with dictionary*/
     func initWithDictionary(responseDictionary : NSDictionary) -> CityWeather
    {
        // Create new BO object and init it with dictionary values
        let cityWeatherBO = CityWeather()
        cityWeatherBO.cityWeatherdescription = responseDictionary["description"] as! String
        return cityWeatherBO
    }
    
}
