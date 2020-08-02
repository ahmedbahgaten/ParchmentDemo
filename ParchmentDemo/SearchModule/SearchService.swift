//
//  SearchService.swift
//  ParchmentDemo
//
//  Created by AHMED on 7/29/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
import Alamofire
class SearchService {
    static func getCountries(completionHandler:@escaping (([Countries]?,Error?) -> ())){
        let url = Constants.citiesUrl
        Alamofire.request(url, method: .get, parameters: nil, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let responseData = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode([Countries].self, from: responseData)
                    completionHandler(decodedData,nil)
                }catch let err {
                    print("Error has occured,couldn't decode the data")
                    completionHandler(nil,err)
                }
            case .failure(let err):
                print("Error has occured,couldn't connect to the server")
                completionHandler(nil,err)
            }
        }
    }
}
