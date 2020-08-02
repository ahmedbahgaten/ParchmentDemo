//
//  SearchModel.swift
//  ParchmentDemo
//
//  Created by AHMED on 7/29/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
struct Countries:Codable {
    let country,city,latitude,longitude:String?
    
    enum CodingKeys:String,CodingKey {
        case country
        case latitude = "lat"
        case longitude = "lng"
        case city = "name"
    }
}
