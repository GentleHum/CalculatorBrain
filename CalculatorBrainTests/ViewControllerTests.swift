//
//  ViewControllerTests.swift
//  CalculatorBrain
//
//  Created by Mike Vork on 12/25/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import XCTest
@testable import CalculatorBrain

class ViewControllerTests: XCTestCase {
    
    var controller: ViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controller = ViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDescription1() {
        _ = controller?.view  // triggers loading of the view controller
//        let button = UIButton()
//        button.setTitle(title: "8",
        
//        XCTAssertEqual(viewController)
    }
    
}
