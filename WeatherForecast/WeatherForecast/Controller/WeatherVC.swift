//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by Shruti Sharma on 2/3/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var weathermoodImgview: UIImageView!
    @IBOutlet weak var weathermoodLbl: UILabel!
    
    var forecast_array = [ForecastWeatherList]()
    let serviceManager = DataServiceManager()
    let locationManager = CLLocationManager()

    //MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        determineCurrentLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Get Current Weather and Update UI

    func determineCurrentLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation() // to get the location only once
        }
    }
    
    func downloadWeatherInfo() {
        serviceManager.getCurrentWeatherData { (weather, error) in
            if let weather = weather, error == nil {
                self.updateUIWithCurrentWeather(weather)
            }
            else {
                print("Failed to get current weather")
            }
        }
        
        serviceManager.getForecastWeatherData { (weather, error) in
            if let weather = weather, error == nil {
                for list in weather.list {
                    self.forecast_array.append(list)
                }
                self.tblView.reloadData()
            }
            else {
                print("Failed to get forecast weather")
            }
        }
    }
    
    func updateUIWithCurrentWeather(_ weather: CurrentWeather) {
        cityLbl.text = weather.city
        dateLbl.text = weather.date
        weathermoodLbl.text = weather.weather[0].type
        let temp: String = String(weather.main.temp)
        tempLbl.text = temp.appending("°")
        weathermoodImgview.image = UIImage(named: weather.weather[0].type)
    }


    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecast_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastWeatherCell", for: indexPath)
            as? ForecastWeatherTableViewCell {
            
            let weather = self.forecast_array[indexPath.row]
            cell.configureCell(with: weather)
            return cell
        }
        else {
            return ForecastWeatherTableViewCell()
        }
    }
    
    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - CLLocationManagerDelegate

extension WeatherVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[locations.count-1] as CLLocation // we use last object in the array becoz it is the most accurate value
        
        Location.sharedInstance.lattitude = userLocation.coordinate.latitude
        Location.sharedInstance.longitude = userLocation.coordinate.longitude
        print("lattitude = \(Location.sharedInstance.lattitude)")
        print("longitude = \(Location.sharedInstance.longitude)")

        downloadWeatherInfo()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}





