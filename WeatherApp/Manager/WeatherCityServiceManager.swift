//
//  WeatherCityServiceManager.swift
//  WeatherApp
//
//  Created by Bhushan Abhyankar on 02/05/17.
//  Copyright © 2017 Bhushan Abhyankar. All rights reserved.
//

import UIKit

class WeatherCityServiceManager: NSObject {
    typealias AvailableTestResponseHandler = (CityClimateMainBO?, NSError?) -> Void

    func createRequestToFetchCityData(cityId: String, availableTestResponseHandler: @escaping AvailableTestResponseHandler)  {
        // Set up the URL request
        let todoEndpoint: String = "http://api.openweathermap.org/data/2.5/forecast?id=" + cityId + "&APPID=APIKEy"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error)
                availableTestResponseHandler(nil, error as NSError?)
            return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let responseDict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
               // print("The responseDict is: " + responseDict.description)
                
                
                /**  Logic of BO */
                ////////////////////////////////////////////////////////////////////////////////////////////
                let watherArray = responseDict["list"] as! NSArray
                if watherArray.count > 0{
                availableTestResponseHandler(CityClimateMainBO.initWithDictionary(response: watherArray[0] as! NSDictionary), nil)

                }
                /////////////////////////////////////////////////////////////////////////////////////////////
                
    

            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }
    let AVAILABLE_TEST_URL: String = "tests/test?test_id="
    
    

}
