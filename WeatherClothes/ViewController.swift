//
//  ViewController.swift
//  WeatherClothes
//
//  Created by Meng Wang on 3/16/17.
//  Copyright © 2017 Ryan Lietzenmayer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelTopRecommendation: UILabel!
    @IBOutlet weak var labelBottomRecommendation: UILabel!
    @IBOutlet weak var labelShoeRecommendation: UILabel!
    
    @IBOutlet weak var labelPrecipitation: UILabel!
    @IBOutlet weak var labelHighTemperature: UILabel!
    @IBOutlet weak var labelCurrentTemperature: UILabel!
    @IBOutlet weak var labelLowTemperature: UILabel!
    
    @IBOutlet weak var fieldLatitude: UITextField!
    @IBOutlet weak var fieldLongitude: UITextField!
    
    @IBOutlet weak var buttonSubmit: UIButton!
    
    
    let DEGREE_SYMBOL = "\u{00B0}"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setReadyUI()
        
        //TODO: get current location and use that
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fieldLatChanged(_ sender: Any) {
        //        if fieldLatitude.text?.characters.last! != "N"{
        //            fieldLatitude.text = fieldLatitude.text! + DEGREE_SYMBOL + "N"
        //        }
    }
    @IBAction func fieldLonChanged(_ sender: Any) {
        //        if fieldLongitude.text?.characters.last! != "W"{
        //            fieldLongitude.text = fieldLongitude.text! + DEGREE_SYMBOL + "W"
        //        }
    }
    
    @IBAction func buttonTouchUpInside(_ sender: Any) {
        submitParams()
    }
    
    func getLatitude()->Float{
        var latitudeString = fieldLatitude.text
        
        if (latitudeString?.isEmpty)!{
            latitudeString = "0"
        }
        
        return Float(latitudeString!) ?? 0
    }
    
    func getLongitude()->Float{
        var longitudeString = fieldLongitude.text
        
        if (longitudeString?.isEmpty)!{
            longitudeString = "0"
        }
        
        return Float(longitudeString!) ?? 0
    }
    
    func submitParams(){
        let apiKey = "8bb2f7ef674ad0d34a1e85caab5c2be3"
        let lat = getLatitude()
        let lon = getLongitude()
        
        //build URL from information provided
        var url = "https://api.darksky.net/forecast/"
        url += apiKey+"/"
        url += String(lat)
        url += ","
        url += String(lon)
        
        //Example url
        // forecast/apiKey/lat,lon
        //https://api.darksky.net/forecast/8bb2f7ef674ad0d34a1e85caab5c2be3/37.8267,-122.4233
        
        setWaitingUI()
        getData(urlString: url)
    }
    
    func getData(urlString:String){
        let thisUrlString = URL(string: urlString)
        
        if let url = thisUrlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.setErrorUI()
                    //                    print(error)
                } else {
                    if let usableData = data {
                        print("Got Data", usableData)
                        self.parseData(data: usableData)
                    }
                }
            }
            task.resume()
            
        }
    }
    
    func parseData(data:Data){
        let result = ResultModel()
        
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
        
        if let dictionary = jsonObject as? [String: Any]{
            if let nestedDictionary = dictionary["currently"] as? [String: Any] {
                if let precipitation = nestedDictionary["summary"] as? String {
                    result.precipitation = precipitation
                }
                if let temperature = nestedDictionary["temperature"] as? Double {
                    result.currentTemperature = temperature
                }
            }
            if let nestedDictionary = dictionary["daily"] as? [String: Any] {
                
                // "data" is an array of dictionaries
                if let array = nestedDictionary["data"] as? [Any] {
                    
                    if let firstObject = array.first {
                        //first object in the array gives weather for the current day, second is tomorrow, etc.
                        if let dailyFirstDictionary = firstObject as? [String: Any]{
                            if let temperatureMax = dailyFirstDictionary["temperatureMax"] as? Double {
                                result.highTemperature = temperatureMax
                            }
                            if let temperatureMin = dailyFirstDictionary["temperatureMin"] as? Double {
                                result.lowTemperature = temperatureMin
                            }
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                result.determineRecommendation()
                self.setResultsUI(result: result)
            }
        }
    }
    
    // MARK: - UI Methods
    func setResultsUI(result : ResultModel){
        self.labelTopRecommendation.text = result.recommendedTop?.capitalized
        self.labelBottomRecommendation.text = result.recommendedBottom?.capitalized
        self.labelShoeRecommendation.text = result.recommendedShoes?.capitalized
        
        self.labelPrecipitation.text = result.precipitation?.capitalized
        self.labelHighTemperature.text = "Hi " + String(result.highTemperature) + DEGREE_SYMBOL
        self.labelCurrentTemperature.text = "Now " + String(result.currentTemperature) + DEGREE_SYMBOL
        self.labelLowTemperature.text = "Lo " + String(result.lowTemperature) + DEGREE_SYMBOL
    }
    
    func setReadyUI(){
        self.labelTopRecommendation.text = "Set Coordinates For Recommendation"
        self.labelBottomRecommendation.text = ""
        self.labelShoeRecommendation.text = ""
        
        self.labelPrecipitation.text = "Cloudyness"
        self.labelHighTemperature.text = "Hi"
        self.labelCurrentTemperature.text = "Now"
        self.labelLowTemperature.text = "Lo"
    }
    
    func setWaitingUI(){
        self.labelTopRecommendation.text = "Waiting"
        self.labelBottomRecommendation.text = " "
        self.labelShoeRecommendation.text = " "
        
        self.labelPrecipitation.text = "Cloudyness"
        self.labelHighTemperature.text = "Hi"
        self.labelCurrentTemperature.text = "Now"
        self.labelLowTemperature.text = "Lo"
    }
    
    func setErrorUI(){
        self.labelTopRecommendation.text = "An Error Occurred"
        self.labelBottomRecommendation.text = " "
        self.labelShoeRecommendation.text = " "
        
        self.labelPrecipitation.text = "Cloudyness"
        self.labelHighTemperature.text = "Hi"
        self.labelCurrentTemperature.text = "Now"
        self.labelLowTemperature.text = "Lo"
    }
}
