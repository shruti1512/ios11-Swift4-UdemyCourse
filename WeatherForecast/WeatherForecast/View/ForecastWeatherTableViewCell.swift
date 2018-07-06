//
//  ForecastWeatherTableViewCell.swift
//  rainyshinycloudy
//
//  Created by Shruti Sharma on 2/5/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import UIKit

class ForecastWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherTypeImgView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(with forecastWeather: ForecastWeatherList) {
        minTempLbl.text = String(forecastWeather.temp.tempMin)
        maxTempLbl.text = String(forecastWeather.temp.tempMax)
        let weatherType = forecastWeather.weather[0].type
        weatherTypeLbl.text = weatherType
        weatherTypeImgView.image = UIImage(named: weatherType)
        dayLbl.text = String(forecastWeather.day)
    }
}
