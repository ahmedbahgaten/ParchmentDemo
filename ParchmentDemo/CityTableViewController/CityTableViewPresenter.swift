//
//  CityTableViewPresenter.swift
//  ParchmentDemo
//
//  Created by AHMED on 8/2/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
protocol ICityView:class {
    
}
protocol ICityPresenter {
    func getCountriesCount() -> Int
    func getCityLat(at index:Int) -> String
    func getCityLong(at index:Int) -> String
    func getCityName(at index:Int) -> String
    func presentCityOnMap(cityName:String,cityLat:String,cityLong:String)
}
class CityTableViewPresenter {
    //MARK:-Variables
    var countries = [Countries]()
    //MARK:-Injections
    weak var view:ICityView?
    var router:ICityRouter?
    //MARK:-Init
    init(view:ICityView,router:ICityRouter) {
        self.view = view
        self.router = router
    }
    //MARK:-Functions
}

extension CityTableViewPresenter:ICityPresenter {
    func presentCityOnMap(cityName: String, cityLat: String, cityLong: String) {
        router?.presentCityOnMap(from: view!, cityName: cityName, cityLat: cityLat, cityLong: cityLong)
    }
    
    func getCountriesCount() -> Int {
        return countries.count
    }
    
    func getCityLat(at index: Int) -> String {
        return countries[index].latitude ?? ""
    }
    
    func getCityLong(at index: Int) -> String {
        return countries[index].longitude ?? ""
    }
    
    func getCityName(at index: Int) -> String {
        return countries[index].city ?? ""
    }
    
    
}
