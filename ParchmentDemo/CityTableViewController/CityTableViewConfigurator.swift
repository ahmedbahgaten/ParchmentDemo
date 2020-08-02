//
//  CityTableViewConfigurator.swift
//  ParchmentDemo
//
//  Created by AHMED on 8/2/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
import UIKit
class CityTableViewConfigurator{
    static func configure(cityTableView:CityTableViewController,countries:[Countries]){
        let router = CityTableViewRouter(view: cityTableView)
        let presenter = CityTableViewPresenter(view: cityTableView, router: router)
        presenter.countries = countries
        cityTableView.presenter = presenter
    }
    static func createCityTableViewController() -> CityTableViewController {
          return CityTableViewController()
      }
}
