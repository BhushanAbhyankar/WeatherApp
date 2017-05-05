//
//  WeatherCityListViewController.swift
//  WeatherApp
//
//  Created by Bhushan Abhyankar on 02/05/17.
//  Copyright © 2017 Bhushan Abhyankar. All rights reserved.
//

import Foundation
import UIKit

class WeatherCityListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    //outlets
    
    @IBOutlet weak var tabelView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //ivars
    var cityNameList:Array = ["Sydney","Melbourne", "Brisbane"]
    var cityIdList:Array = ["4163971","2147714", "2174003"]
    var reponseDataArray = NSMutableArray()
    var serviceManager = WeatherCityServiceManager ()
    var cityTempatureSydney = CityClimateMainBO()
    var cityTempatureMelbourne = CityClimateMainBO()
    var cityTempatureBrisbane = CityClimateMainBO()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.activityIndicator.color=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.activityIndicator.startAnimating()
        self.navigationItem.title = "WeatherApp"
        self.sendRequestToGetSydneyCityTempInfo(cityId: cityIdList[0])
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
    
    //MARK: - WebserviceMethods

    func sendRequestToGetSydneyCityTempInfo(cityId: String){
        self.tabelView.isUserInteractionEnabled=false
        serviceManager.createRequestToFetchCityData(cityId: cityId) { (cityTempature, error) in
           self.cityTempatureSydney = cityTempature!
            self.reponseDataArray.add(cityTempature!)
            self.reloadTabelView()
            
            self.sendRequestToGetMelbourneCityTempInfo(cityId: self.cityIdList[1])

        }

    }
    
    func sendRequestToGetMelbourneCityTempInfo(cityId: String){
        serviceManager.createRequestToFetchCityData(cityId: cityId) { (cityTempature, error) in
            self.cityTempatureMelbourne = cityTempature!
            self.reponseDataArray.add(cityTempature!)
            self.reloadTabelView()
            self.sendRequestToGetBrisbaneCityTempInfo(cityId: self.cityIdList[2])

        }
        
    }
    
    func sendRequestToGetBrisbaneCityTempInfo(cityId: String){
        serviceManager.createRequestToFetchCityData(cityId: cityId) { (cityTempature, error) in
            self.cityTempatureBrisbane = cityTempature!
            self.reponseDataArray.add(cityTempature!)
            DispatchQueue.main.async {
            self.reloadTabelView()
            self.activityIndicator.isHidden=true
            self.activityIndicator.stopAnimating()
            self.tabelView.isUserInteractionEnabled=true
            }
            
        }
        
    }


    //MARK: - UITableViewDataSource Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherCityTabelCellID", for: indexPath) as! WeatherCityTabelCell
        weatherCell.labelCityName.text = cityNameList[indexPath.row]
       
        if indexPath.row == 0{
            if self.cityTempatureSydney != nil  {
                let urlString = String(format: "%d°", self.cityTempatureSydney.cityTempObj.cityTempValue.intValue)
        weatherCell.labelCityTemprature.text=urlString
            }
        }
        else if indexPath.row == 1{
            if self.cityTempatureMelbourne != nil  {
                let urlString = String(format: "%d°", self.cityTempatureMelbourne.cityTempObj.cityTempValue.intValue)
                weatherCell.labelCityTemprature.text=urlString
            }
        }
        else if indexPath.row == 2{
            if self.cityTempatureBrisbane != nil  {
                let urlString = String(format: "%d°", self.cityTempatureBrisbane.cityTempObj.cityTempValue.intValue)
                weatherCell.labelCityTemprature.text=urlString
            }
        }
        return weatherCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.reponseDataArray.count>0 {

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WeatherCityDetailsViewControllerID") as! WeatherCityDetailsViewController
            vc.cityDetailsTempature = self.reponseDataArray[indexPath.row] as! CityClimateMainBO
            vc.cityName=cityNameList[indexPath.row]
            navigationController?.pushViewController(vc,animated: true)
        }
    }
    
    //mark local methods
    func reloadTabelView(){
        DispatchQueue.main.async {
            self.tabelView.reloadData()
        }
    }
}

