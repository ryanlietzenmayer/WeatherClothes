//
//  testResultModel.swift
//  WeatherClothes
//
//  Created by Meng Wang on 3/16/17.
//  Copyright © 2017 Ryan Lietzenmayer. All rights reserved.
//

import XCTest
@testable import WeatherClothes

class testResultModel: XCTestCase {
    
    var result: ResultModel!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        result = ResultModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOver100Temperature() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        result.currentTemperature = 200.0
        result.determineRecommendation()
        
        XCTAssert(result.recommendedTop == "naked")
    }

}
