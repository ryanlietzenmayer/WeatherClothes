//
//  ResultModel.swift
//  WeatherClothes
//
//  Created by Meng Wang on 3/16/17.
//  Copyright © 2017 Ryan Lietzenmayer. All rights reserved.
//

import Foundation

class ResultModel {
    
    var recommendedTop: String?
    var recommendedBottom: String?
    var recommendedShoes: String?
    
    var precipitation: String?
    
    var isFahrenheit: Bool?
    var currentTemperature = 0.0
    var highTemperature = 0.0
    var lowTemperature = 0.0

    
    func determineRecommendation(){
        recommendedBottom = "pants"
        recommendedShoes = "shoes"
        
        if currentTemperature > 100{
            recommendedTop = "naked"
            recommendedBottom = "whatever you don't mind getting swampy"
            recommendedShoes = "anything to keep your feet from burning"
        }
        else if currentTemperature > 80{
            recommendedTop = "tank top"
            recommendedBottom = "shorts"
            recommendedShoes = "sandals"
        }
        else if currentTemperature > 60{
            recommendedTop = "t-shirt"
            recommendedBottom = "pants"
            recommendedShoes = "shoes"
        }
        else if currentTemperature > 40{
            recommendedTop = "sweater"
            recommendedBottom = "pants"
            recommendedShoes = "shoes"
        }
        else if currentTemperature > 20{
            recommendedTop = "coat"
            recommendedBottom = "pants"
            recommendedShoes = "shoes"
        }
        else if currentTemperature > 0{
            recommendedTop = "winter coat"
            recommendedBottom = "warm pants"
            recommendedShoes = "boots"
        }
        else if currentTemperature > -20{
            recommendedTop = "hardcore winter gear"
            recommendedBottom = "ski pants"
            recommendedShoes = "snow boots"
        }
        else{
            recommendedTop = "arctic expedition coat"
            recommendedBottom = "insane longjohns"
            recommendedShoes = "professional ice climbing boots"
        }
    }
}
