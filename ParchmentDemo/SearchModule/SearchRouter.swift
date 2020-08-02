//
//  SearchRouter.swift
//  ParchmentDemo
//
//  Created by AHMED on 7/29/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
protocol ISearchRouter {
    
}
class SearchRouter {
    //MARK:-Variables
    private var view:ISearchView?
    init(view:ISearchView) {
        self.view = view
    }
}

extension SearchRouter:ISearchRouter {
    
}
