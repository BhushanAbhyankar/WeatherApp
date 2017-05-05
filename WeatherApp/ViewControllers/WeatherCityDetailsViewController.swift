//
//  WeatherCityDetailsViewController.swift
//  WeatherApp
//
//  Created by Bhushan Abhyankar on 05/05/17.
//  Copyright © 2017 Bhushan Abhyankar. All rights reserved.
//

import UIKit

class WeatherCityDetailsViewController: UIViewController {

    //var
    var cityDetailsTempature = CityClimateMainBO()
    var cityName = String()
    
    
    //outlets
    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBOutlet weak var labelMainTemp: UILabel!
    
    @IBOutlet weak var labelMinTemp: UILabel!
    
    @IBOutlet weak var labelMaxTemp: UILabel!
    
    @IBOutlet weak var labelHumidity: UILabel!
    
    @IBOutlet weak var labelPressure: UILabel!
    
    @IBOutlet weak var labelCityName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayDataInView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - data display
    func displayDataInView()  {
        DispatchQueue.main.async {
            self.labelMaxTemp.text=String(format: "Maximum Temp\n%d°", self.cityDetailsTempature.cityTempObj.temp_max.intValue)
           self.labelMinTemp.text=String(format: "Minimum Temp\n%d°", self.cityDetailsTempature.cityTempObj.temp_min.intValue)
            self.labelHumidity.text=String(format: "Humidity\n%d%", self.cityDetailsTempature.cityTempObj.humidity.intValue)
            self.labelPressure.text=String(format: "Pressure\n%dhpa", self.cityDetailsTempature.cityTempObj.pressure.intValue)
            self.labelMainTemp.text=String(format: "%d°",self.cityDetailsTempature.cityTempObj.temp_max.intValue)
            self.weatherDescription.text=String(format: "%@", self.cityDetailsTempature.cityWeatherObj.cityWeatherdescription)
            
            self.labelCityName.text=String(format: "%@", self.cityName)

        }
    }
}
