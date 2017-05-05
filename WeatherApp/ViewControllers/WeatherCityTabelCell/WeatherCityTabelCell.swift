//
//  WeatherCityTabelCell.swift
//  WeatherApp
//
//  Created by Bhushan Abhyankar on 02/05/17.
//  Copyright © 2017 Bhushan Abhyankar. All rights reserved.
//

import UIKit

class WeatherCityTabelCell: UITableViewCell {
    
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelCityTemprature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
