//
//  json_constants.swift
//  Weather-Forcast
//
//  Created by Brandon Innis on 5/03/17.
//  Copyright © 2017 Brandon Innis. All rights reserved.
//

import Foundation
// These varibles hold my constants
let request_url = "http://api.openweathermap.org/data/2.5/weather?"

let lat = "lat="
let long = "&lon="
let id_number = "&appid="

//  let apiKey = insert your api key from https://openweathermap.org/api
var lat_num = 0.0
var long_num = 0.0
var current_url = request_url + lat + String(lat_num) + long + String(long_num) + id_number + api_key


