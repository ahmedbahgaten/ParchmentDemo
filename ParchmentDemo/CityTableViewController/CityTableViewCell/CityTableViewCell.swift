//
//  CityTableViewCell.swift
//  ParchmentDemo
//
//  Created by AHMED on 8/2/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    //MARK:-Variables
    
    //MARK:-Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    //MARK:-Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    func configure(cityName:String,lat:String,long:String){
        cityNameLabel.text = cityName
        latLabel.text = lat
        longLabel.text = long
    }
    
    
}
