//
//  CityTableViewController.swift
//  ParchmentDemo
//
//  Created by AHMED on 8/2/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {
    //MARK:-Variables
    var presenter:ICityPresenter?
    //MARK:-Outlets
    
    //MARK:-ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        tableView.reloadData()
        
    }
    //MARK:-Functions
    private func registerTableViewCell() {
        let cityCell = UINib(nibName: Constants.cityTableViewCell, bundle: nil)
        tableView.register(cityCell, forCellReuseIdentifier: Constants.cityCellID)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getCountriesCount() ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cityCellID, for: indexPath) as! CityTableViewCell
        let lat = presenter?.getCityLat(at: indexPath.row) ?? ""
        let long = presenter?.getCityLong(at: indexPath.row) ?? ""
        let cityName = presenter?.getCityName(at: indexPath.row) ?? ""
        cell.configure(cityName: cityName, lat: lat, long: long)
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lat = presenter?.getCityLat(at: indexPath.row) ?? ""
        let long = presenter?.getCityLong(at: indexPath.row) ?? ""
        let cityName = presenter?.getCityName(at: indexPath.row) ?? ""
        presenter?.presentCityOnMap(cityName: cityName, cityLat: lat, cityLong: long)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension CityTableViewController:ICityView {
    
}
