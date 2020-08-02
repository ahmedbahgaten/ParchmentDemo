//
//  SearchViewController.swift
//  ParchmentDemo
//
//  Created by AHMED on 7/29/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit
import Parchment
import NVActivityIndicatorView
class SearchViewController: UIViewController {
    //MARK:-Dependencies
    var presenter:ISearchPresenter?
    var pagingViewController:PagingViewController!
    var pagingViewControllerDelegateAndDataSource:PagingViewControllerDelegateAndDataSource!
    //MARK:-Outlets
    @IBOutlet weak var pagingViewControllerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    @IBOutlet weak var searchTxtField: UITextField!{
        didSet{
            searchTxtField.addTarget(self, action: #selector(searchContentDidChange), for: .editingChanged)
            searchTxtField.delegate = self
        }
    }
    
    //MARK:-ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupView()
        presenter?.getCountries()
    }
    //MARK:-Functions
    @objc private func searchContentDidChange() {
        presenter?.checkOnSearchTxtField(text: searchTxtField.text ?? "")
    }
    private func configure() {
        SearchConfigurator.configure(searchVC: self)
    }
    private func setupPagingDelegateAndDataSource() {
        pagingViewController.dataSource = pagingViewControllerDelegateAndDataSource
        pagingViewController.select(index: 0)
    }
    private func setupView() {
        navigationController?.navigationBar.isHidden = true
        pagingViewController.backgroundColor = .clear
        addChild(pagingViewController)
        containerView.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: pagingViewControllerView.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: pagingViewControllerView.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: pagingViewControllerView.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: pagingViewControllerView.topAnchor)
        ])
    }
    
    //MARK:-Actions
}
//MARK:-Extension
extension SearchViewController:ISearchView{
    func decreaseViewAlpha() {
        containerView.alpha = 0.5
    }
    
    func increaseViewAlpha() {
        containerView.alpha = 1.0
    }
    
    func reloadData() {
        pagingViewController.reloadData()
    }
    
    func dataLoadedSuccessfully() {
        setupPagingDelegateAndDataSource()
        pagingViewController.reloadData()
    }
    
    func showLoading() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: Constants.errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
extension SearchViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
