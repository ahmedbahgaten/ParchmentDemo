//
//  SearchConfigurator.swift
//  ParchmentDemo
//
//  Created by AHMED on 7/29/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
import Parchment
class SearchConfigurator{
    static func configure(searchVC:SearchViewController){
        let router = SearchRouter(view: searchVC)
        let presenter = SearchPresenter(view: searchVC, router: router)
        let pagingViewController = PagingViewController()
        let pagingViewControllerDataSource = PagingViewControllerDelegateAndDataSource()
        searchVC.pagingViewController = pagingViewController
        searchVC.pagingViewControllerDelegateAndDataSource = pagingViewControllerDataSource
        searchVC.pagingViewControllerDelegateAndDataSource.presenter = presenter
        searchVC.presenter = presenter
    }
  
}
