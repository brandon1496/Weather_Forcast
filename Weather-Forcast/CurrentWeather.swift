//
//  CurrentWeather.swift
//  Weather-Forcast
//
//  Created by Brandon Innis on 5/06/17.
//  Copyright © 2017 Brandon Innis. All rights reserved.
//

import UIKit
import Alamofire
// class to hold the weather data
class CurrentWeather {
    var _cityname: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    var cityName: String {
        if _cityname == nil {
            _cityname = ""
            
        }
        return _cityname
    }
    //
    var date: String {
        if _date == nil {
            _date = ""
        }
        // formats the date
        let dateFormattor = DateFormatter()
        dateFormattor.dateStyle = .long
        dateFormattor.timeStyle = .none
        let currentDate = dateFormattor.string(from: Date())
        
        self._date = currentDate
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    // funcetion that handles interating with the data and parsing through the given data
    func weather_info(completed: @escaping DownloadComplete) {
        //Alamofire download
        let currentWeatherUrl = URL(string: current_url)!
      
        Alamofire.request(currentWeatherUrl).responseJSON { response in
            let result = response.result
           
     
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String{
                    self._cityname = name.capitalized
                    
                   
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                       
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemp = main["temp"] as? Double {
                        // kelvin to Farenheit before it gets divided
                        let kevlin_toF = (currentTemp * (9/5) - 459.67)
                        let final_temp = Double(round(10 * kevlin_toF/10))
                        self._currentTemp = final_temp
                        
                       
                    }
                }
                completed()
            }
          
        }
        
        
    }
    
    
// needed whenever you are downloading info
typealias DownloadComplete = () -> ()    
    
}
