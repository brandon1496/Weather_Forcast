//
//  ViewController.swift
//  Weather-Forcast
//
//  Created by Brandon Innis on 5/17/17.
//  Copyright © 2017 Brandon Innis. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var datelbl: UILabel!
    
    @IBOutlet weak var current_templbl: UILabel!
    
    
    
    @IBOutlet weak var locationlbl: UILabel!
    
    @IBOutlet weak var current_weather_img: UIImageView!

    @IBOutlet weak var current_weatherlbl: UILabel!
    
   
    
    var long: Double = 0.0
    var lat : Double = 0.0
    let manager = CLLocationManager()
    
    var currentlocation: CLLocation!
    func auth_status (){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentlocation = manager.location
            long = (manager.location?.coordinate.longitude)!
            lat = (manager.location?.coordinate.latitude)!
            lat_num = lat
            long_num = long
            currentWeather.weather_info {
                self.forcast_data {
                    self.update_table()
                }
                
                
            }
            print(long)
            print(lat)
            print("hiiiiiiiiiiiii")
            
        }
        else {
            manager.requestWhenInUseAuthorization()
            auth_status()
        }
    }
    
    
   
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
  
   

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startMonitoringSignificantLocationChanges()
      
        
        currentWeather = CurrentWeather()
            }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.auth_status()
    }
    
    func forcast_data(completed: DownloadComplete) {
          // download forcast data for weather tableview
        let forecastUrl = URL(string: current_url)!
        Alamofire.request(forecastUrl).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        
                        
                    }
                }
            }
        }
            completed()
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weather_cell", for: indexPath)
        return cell
    }
    
    func update_table(){
        datelbl.text = currentWeather.date
        current_templbl.text = String(currentWeather.currentTemp)
        current_weatherlbl.text = currentWeather.weatherType
        locationlbl.text = currentWeather.cityName
        current_weather_img.image = UIImage(named: currentWeather.weatherType)
        
    }
    
        
        
        
        
        
        
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

