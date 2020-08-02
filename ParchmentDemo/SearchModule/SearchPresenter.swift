//
//  SearchPresenter.swift
//  ParchmentDemo
//
//  Created by AHMED on 7/29/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
protocol ISearchView:class {
    func showLoading()
    func hideLoading()
    func decreaseViewAlpha()
    func increaseViewAlpha()
    func showError()
    func dataLoadedSuccessfully()
    func reloadData()
    
}
protocol ISearchPresenter {
    func getCountries()
    func checkOnSearchTxtField(text:String)
    func getCountryName(at index:Int) -> String
    func getCountriesCount() -> Int
    func getCitiesWithCountryName(countryName:String) -> [Countries]
}
class SearchPresenter {
    //MARK:-Variables
    private weak var view:ISearchView?
    private var router:ISearchRouter?
    private var countries = [Countries]()
    private var countriesCopy = [Countries]()
    private var countriesName = [String]()
    private var countriesNameCopy = [String]()
    private var searchTimer: Timer?
    
    //MARK:-Init
    init(view:ISearchView,router:ISearchRouter) {
        self.view = view
        self.router = router
    }
    //MARK:-Functions
    private func startTimer(text:String) {
        //Every time the user types any letter in the searchBar, the timer will stop and re-start again for smooth writing experience.
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
            self.filterCountries(text: text)
        })
    }
    private func showFilteredData(text:String) {
        self.countriesName.removeAll()
        self.countries.removeAll()
        self.countriesName = self.countriesNameCopy.filter{($0.lowercased().contains(text.lowercased()))}
        self.countries = self.countriesCopy.filter{($0.country?.lowercased().contains(text.lowercased()) ?? false)}
        if countriesName.isEmpty {
            self.countries = self.countriesCopy.filter{($0.city?.lowercased().contains(text.lowercased()) ?? false)}
            self.countriesName = countries.map{$0.country ?? ""}
            self.countriesName.removeDuplicates()
        }
    }
    
    private func handleResponse(countries:[Countries]) {
        self.countries = countries
        self.countriesCopy = countries
        self.countriesName = countries.map{$0.country ?? ""}
        self.countriesName.removeDuplicates()
        self.countriesNameCopy = self.countriesName
    }
    
    @objc private func filterCountries(text:String) {
        if text == "" {
            self.countriesName = self.countriesNameCopy
            self.countries = self.countriesCopy
        }else {
         showFilteredData(text: text)
        }
        self.view?.hideLoading()
        self.view?.reloadData()
    }
}
extension SearchPresenter:ISearchPresenter {
    func getCitiesWithCountryName(countryName: String) -> [Countries] {
        return countries.filter{$0.country == countryName}
    }
    
    func getCountriesCount() -> Int {
        return countriesName.count
    }
    
    func getCountryName(at index: Int) -> String {
        return countriesName[index]
    }
    func checkOnSearchTxtField(text: String) {
        view?.showLoading()
        startTimer(text: text)
    }
    
    func getCountries() {
        view?.showLoading()
        view?.decreaseViewAlpha()
        SearchService.getCountries { [weak self] (response, err) in
            guard let self = self else {return}
            if let err = err {
                print("Error has occured",err.localizedDescription)
                self.view?.hideLoading()
                self.view?.increaseViewAlpha()
                self.view?.showError()  
            }else {
                guard let countries = response else {return}
                self.handleResponse(countries:countries)
                self.view?.hideLoading()
                self.view?.increaseViewAlpha()
                self.view?.dataLoadedSuccessfully()
            }
        }
    }
}

