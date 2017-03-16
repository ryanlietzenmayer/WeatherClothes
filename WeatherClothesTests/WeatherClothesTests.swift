//
//  WeatherClothesTests.swift
//  WeatherClothesTests
//
//  Created by Ryan Lietzenmayer on 3/16/17.
//  Copyright © 2017 Ryan Lietzenmayer. All rights reserved.
//

import XCTest
@testable import WeatherClothes

class WeatherClothesTests: XCTestCase {
    var vc: ViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateInitialViewController() as! ViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetLatitude() {
        //Accesses the view to trigger viewDidLoad().
        let _ = vc.view
        
        //-90 to 90 for latitude
        vc.fieldLatitude.text = ""
        XCTAssert(0 == vc.getLatitude())
        
        vc.fieldLatitude.text = " "
        XCTAssert(0 == vc.getLatitude())
        
        vc.fieldLatitude.text = "0.0"
        XCTAssert(0 == vc.getLatitude())
        
        vc.fieldLatitude.text = "1.0"
        XCTAssert(1 == vc.getLatitude())
        
        vc.fieldLatitude.text = "1.1"
        XCTAssert(1.1 == vc.getLatitude())
        
        vc.fieldLatitude.text = "91"
        XCTAssert(90 == vc.getLatitude())
        vc.fieldLatitude.text = "-91"
        XCTAssert(-90 == vc.getLatitude())
        
        vc.fieldLatitude.text = "F"
        XCTAssert(0 == vc.getLatitude())
        
        vc.fieldLatitude.text = "FGHIJKL"
        XCTAssert(0 == vc.getLatitude())
        
        vc.fieldLatitude.text = " FFF "
        XCTAssert(0 == vc.getLatitude())
    }
    func testGetLongitude() {
        //Accesses the view to trigger viewDidLoad().
        let _ = vc.view
        
        //-180 to 180 for longitude
        vc.fieldLongitude.text = ""
        XCTAssert(0 == vc.getLongitude())
        
        vc.fieldLongitude.text = " "
        XCTAssert(0 == vc.getLongitude())
        
        vc.fieldLongitude.text = "0.0"
        XCTAssert(0 == vc.getLongitude())
        
        vc.fieldLongitude.text = "1.0"
        XCTAssert(1 == vc.getLongitude())
        
        vc.fieldLongitude.text = "1.1"
        XCTAssert(1.1 == vc.getLongitude())
        
        vc.fieldLongitude.text = "181"
        XCTAssert(180 == vc.getLongitude())
        
        vc.fieldLongitude.text = "-181"
        XCTAssert(-180 == vc.getLongitude())
        
        vc.fieldLongitude.text = "F"
        XCTAssert(0 == vc.getLongitude())
        
        vc.fieldLongitude.text = "FGHIJKL"
        XCTAssert(0 == vc.getLongitude())
        
        vc.fieldLongitude.text = " WWW "
        XCTAssert(0 == vc.getLongitude())
        
        vc.fieldLongitude.text = "12WJFG"
        XCTAssert(0 == vc.getLongitude())
        
        vc.fieldLongitude.text = "1W5J2FG"
        XCTAssert(0 == vc.getLongitude())
    }
    
}
