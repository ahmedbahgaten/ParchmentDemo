//
//  PagingViewControllerDelegateAndDataSource.swift
//  ParchmentDemo
//
//  Created by AHMED on 7/29/20.
//  Copyright © 2020 AHMED. All rights reserved.
//
import Foundation
import Parchment
class PagingViewControllerDelegateAndDataSource:NSObject,PagingViewControllerDataSource,PagingViewControllerDelegate{
    //MARK:-Variables
    var presenter:ISearchPresenter?
    
    
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        presenter?.getCountriesCount() ?? 0
    }
    func pagingViewController(_ pagingViewController: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let cityTableViewController = CityTableViewConfigurator.createCityTableViewController()
        let countryName = presenter?.getCountryName(at: index)
        let countries = presenter?.getCitiesWithCountryName(countryName: countryName ?? "") ?? []
        CityTableViewConfigurator.configure(cityTableView: cityTableViewController, countries: countries)
        return cityTableViewController
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let title = presenter?.getCountryName(at: index) ?? ""
        return PagingIndexItem(index: index, title:title)
    }
}
