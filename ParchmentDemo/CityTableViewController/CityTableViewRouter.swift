//
//  CityTableViewRouter.swift
//  ParchmentDemo
//
//  Created by AHMED on 8/2/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
protocol ICityRouter {
    func presentCityOnMap(from view:ICityView,cityName:String,cityLat:String,cityLong:String)
}

class CityTableViewRouter{
    var view:ICityView?
    init(view:ICityView) {
        self.view = view
    }
}

extension CityTableViewRouter:ICityRouter {
    func presentCityOnMap(from view:ICityView,cityName:String,cityLat:String,cityLong:String) {
        let mapVC = MapViewController(latitude: cityLat, longitude: cityLong, cityName: cityName)
        if let view = view as? CityTableViewController {
            view.present(mapVC, animated: true, completion: nil)
        }
    }
}
