//
//  ViewController.swift
//  Weather-Forcast
//
//  Created by Brandon Innis on 5/03/17.
//  Copyright © 2017 Brandon Innis. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    
 // IBO conenctions to the frontend of the app
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var datelbl: UILabel!
    
    @IBOutlet weak var current_templbl: UILabel!
    
    
    
    @IBOutlet weak var locationlbl: UILabel!
    
    @IBOutlet weak var current_weather_img: UIImageView!

    @IBOutlet weak var current_weatherlbl: UILabel!
    
   
    
    let manager = CLLocationManager()
  
    var currentlocation: CLLocation!
    
    // function checks if user agrees for the app to use his or location
    func auth_status (){
        // if runs when the user click yes
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            currentlocation = manager.location
            // gets the longitude
            long_num = (manager.location?.coordinate.longitude)!
            //  gets the latitude
            lat_num = (manager.location?.coordinate.latitude)!
            // sends the request
            current_url = request_url + lat + String(lat_num) + long + String(long_num) + id_number + api_key
            
            // parse throught the data and set it to the currentweather object
            currentWeather.weather_info {
                    // updates the front end with the new data
                    self.update_table()
                                        }
                
                
          
            
        }
        // runs when user clicks no
        else {
            //manager.requestWhenInUseAuthorization()
            //auth_status()
            }
                        }
    
    
   
    
    var currentWeather: CurrentWeather!
    
    // handles when user wants to search for a city or town
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // removes the space in the city or town name
        var city = searchBar.text!.replacingOccurrences(of: " ", with: "%20");
        // if user types in Current location
        if searchBar.text! == "Current location" {
            auth_status()
            // closes keyboard
            searchBar.endEditing(true)
        }
        // when use types in a city or town name and not current location
        else{
            
        
        current_url = "http://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + api_key
        searchBar.endEditing(true)
           // updates the currentweather
        currentWeather.weather_info {
            
            self.update_table()
        }
        }
        
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        searchBar.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startMonitoringSignificantLocationChanges()
      
        
        currentWeather = CurrentWeather()
            }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.auth_status()
    }
    

        // updates the frontend with the new info
    func update_table()
    {
        datelbl.text = currentWeather.date
        current_templbl.text = String(Int(currentWeather.currentTemp)) + "°"
        current_weatherlbl.text = currentWeather.weatherType
        locationlbl.text = currentWeather.cityName
        current_weather_img.image = UIImage(named: currentWeather.weatherType)
        
    }
    
        
        
        
        
        
        
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

