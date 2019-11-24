//
//  PlaceWeatherTableViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/14.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class PlaceWeatherTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        placeDescription.textColor = .steel
        placeTitle.textColor = .charcoalGrey
        raindaysValue.textColor = .charcoalGrey
        raindaysDesc.textColor = .charcoalGrey
        averageTempValue.textColor = .charcoalGrey
        averageTempDesc.textColor =  .charcoalGrey
        averageSeoulTempDesc.textColor = .charcoalGrey
        averageSeoulTempValue.textColor = .charcoalGrey
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func populate(weather:Weather){
        placeTitle.text = weather.title
        placeDescription.text = weather.description
        raindaysValue.text = String(Int(weather.raindays)) + "일"
        averageTempValue.text = String(Int(weather.average_temp)) + "°C"
        averageSeoulTempValue.text = String(Int(weather.seoul_temp)) + "°C"
    }

    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeDescription: UILabel!
    @IBOutlet weak var raindaysValue: UILabel!
    @IBOutlet weak var raindaysDesc: UILabel!
    @IBOutlet weak var averageTempValue: UILabel!
    @IBOutlet weak var averageTempDesc: UILabel!
    @IBOutlet weak var averageSeoulTempValue: UILabel!
    @IBOutlet weak var averageSeoulTempDesc: UILabel!
}

