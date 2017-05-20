//
//  json_constants.swift
//  Weather-Forcast
//
//  Created by Brandon Innis on 5/18/17.
//  Copyright © 2017 Brandon Innis. All rights reserved.
//

import Foundation

let request_url = "http://api.openweathermap.org/data/2.5/weather?"

let lat = "lat="
let long = "&lon="
let id_number = "&appid="
let api_key = "6109888a54ff86adf5560485e734fc1e"

typealias DownloadComplete = () -> ()

var lat_num = 0.0
var long_num = 0.0
let current_url = request_url + lat + String(lat_num) + long + String(long_num) + id_number + api_key

//let forecast_url = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=-31&lon=123&cnt=10&appid=6109888a54ff86adf5560485e734fc1e"
