//
//  CalculatorBrainTests.swift
//  CalculatorBrainTests
//
//  Created by Mike Vork on 12/23/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import XCTest
@testable import CalculatorBrain

class CalculatorBrainTests: XCTestCase {
    
    var brain = CalculatorBrain()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        brain.clear()
        brain.variableValues.removeAll()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    func testDescription_7a() {
        brain.setOperand(operand: 7.0)
        brain.performOperation(symbol: "+")
        XCTAssertEqual(brain.description, "7 + ")
    }
    
    func testDescription_7b() {
        brain.setOperand(operand: 7.0)
        brain.performOperation(symbol: "+")
        brain.setOperand(operand: 9.0)
        XCTAssertEqual(brain.description, "7 + 9")
    }
    
    func testDescription_7c() {
        brain.setOperand(operand: 7.0)
        brain.performOperation(symbol: "+")
        brain.setOperand(operand: 9.0)
        brain.performOperation(symbol: "=")
        XCTAssertEqual(brain.description, "7 + 9")
    }
    
    func testDescription_7d() {
        brain.setOperand(operand: 7.0)
        brain.performOperation(symbol: "+")
        brain.setOperand(operand: 9.0)
        brain.performOperation(symbol: "=")
        brain.performOperation(symbol: "√")
        XCTAssertEqual(brain.description, "√(7 + 9)")
    }
    
    func testDescription_7e() {
        brain.setOperand(operand: 7.0)
        brain.performOperation(symbol: "+")
        brain.setOperand(operand: 9.0)
        brain.performOperation(symbol: "√")
        XCTAssertEqual(brain.description, "7 + √(9)")
    }
    
    func testDescription_7f() {
        brain.setOperand(operand: 7.0)
        brain.performOperation(symbol: "+")
        brain.setOperand(operand: 9.0)
        brain.performOperation(symbol: "√")
        brain.performOperation(symbol: "=")
        XCTAssertEqual(brain.description, "7 + √(9)")
    }
    
    func testDescription_7g() {
        brain.setOperand(operand: 7.0)
        brain.performOperation(symbol: "+")
        brain.setOperand(operand: 9.0)
        brain.performOperation(symbol: "=")
        brain.performOperation(symbol: "+")
        brain.setOperand(operand: 6.0)
        brain.performOperation(symbol: "+")
        brain.setOperand(operand: 3.0)
        brain.performOperation(symbol: "=")
        XCTAssertEqual(brain.description, "7 + 9 + 6 + 3")
    }
    
    func testDescription_7h() {
        brain.setOperand(operand: 7.0)
        brain.performOperation(symbol: "+")
        brain.setOperand(operand: 9.0)
        brain.performOperation(symbol: "=")
        brain.performOperation(symbol: "√")
        brain.setOperand(operand: 6.0)
        brain.performOperation(symbol: "+")
        brain.setOperand(operand: 3.0)
        brain.performOperation(symbol: "=")
        XCTAssertEqual(brain.description, "6 + 3")
    }
    
    func testDescription_7i() {
        brain.setOperand(operand: 5.0)
        brain.performOperation(symbol: "+")
        brain.setOperand(operand: 6.0)
        brain.performOperation(symbol: "=")
        brain.setOperand(operand: 73.0)
        XCTAssertEqual(brain.description, "73")
    }
    
    func testDescription_7j() {
        brain.setOperand(operand: 7.0)
        brain.performOperation(symbol: "+")
        brain.performOperation(symbol: "=")
        XCTAssertEqual(brain.description, "7 + 7")
    }
    
    func testDescription_7k() {
        brain.setOperand(operand: 4.0)
        brain.performOperation(symbol: "×")
        brain.performOperation(symbol: "π")
        brain.performOperation(symbol: "=")
        XCTAssertEqual(brain.description, "4 × π")
    }
    
    func testDescription_7l() {
        brain.setOperand(operand: 4.0)
        brain.performOperation(symbol: "÷")
        brain.setOperand(operand: 5.0)
        brain.performOperation(symbol: "×")
        brain.setOperand(operand: 3.0)
        brain.performOperation(symbol: "=")
        XCTAssertEqual(brain.description, "4 ÷ 5 × 3")
    }
    
    func testDescription_7m() {
        brain.setOperand(operand: 20.0)
        brain.performOperation(symbol: "÷")
        brain.setOperand(operand: 5.0)
        brain.performOperation(symbol: "=")
        XCTAssertEqual(brain.description, "20 ÷ 5")
    }
    
    func testDescription_7n() {
        brain.setOperand(operand: 7.2)
        brain.performOperation(symbol: "÷")
        brain.setOperand(operand: 8.11)
        brain.performOperation(symbol: "=")
        XCTAssertEqual(brain.description, "7.2 ÷ 8.11")
    }
    
    func testDescription_7o() {
        brain.setOperand(operand: 7.0)
        brain.performOperation(symbol: "÷")
        brain.performOperation(symbol: "÷")
        XCTAssertEqual(brain.description, "7 ÷ 7 ÷ ")
    }
    
}
