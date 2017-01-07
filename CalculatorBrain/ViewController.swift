//
//  ViewController.swift
//  Calculator
//
//  Created by Mike Vork on 12/19/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    private var userIsTypingNumber = false
    private var brain = CalculatorBrain()
    
    private var displayValue: Double? {
        get {
            return Double(resultLabel.text!)
        }
        set {
            resultLabel.text = (newValue != nil) ? formatDisplayString(newValue!) : "0"
        }
    }
    
    @IBAction private func storeVariable(_ sender: UIButton) {
        // remove the leading arrow to get the variable name
        let variableName = sender.currentTitle!.trimmingCharacters(in: CharacterSet(charactersIn: "→"))
        
        brain.variableValues[variableName] = displayValue
        
        updateDisplay()
    }
    
    
    @IBAction private func useVariable(sender: UIButton) {
        let variableName = sender.currentTitle!
        
        brain.setOperand(variableName: variableName)
        updateDisplay()        
    }
    
    @IBAction private func undo() {
        if userIsTypingNumber {
            if resultLabel.text!.characters.count > 1 {
                // remove last character from result
                resultLabel.text! = resultLabel.text!.substring(to: resultLabel.text!.index(before: resultLabel.text!.endIndex))
            } else {
                // handle the resulting blank string case
                displayValue = nil
                userIsTypingNumber = false
            }
        } else {
            if var currentProgram = brain.program as? [AnyObject] {
                if currentProgram.count > 0 {
                    currentProgram.removeLast()
                    brain.program = currentProgram as CalculatorBrain.PropertyList
                }
            }
            updateDisplay()
        }
    }
    
    @IBAction private func clear() {
        brain.clear()
        userIsTypingNumber = false
        displayValue = nil
        descriptionLabel.text = " "
        brain.variableValues.removeAll()        
    }
    
    @IBAction private func addDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTypingNumber {
            let resultText = resultLabel.text!
            if digit != "." || resultText.range(of: ".") == nil {
                resultLabel.text = resultText + digit
            }
        } else {
            resultLabel.text = (digit == ".") ? "0." : digit
            userIsTypingNumber = true
        }
    }
    
    
    @IBAction private func operate(sender: UIButton) {
        if userIsTypingNumber {
            if displayValue != nil {
                brain.setOperand(operand: displayValue!)
            }
            userIsTypingNumber = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        
        updateDisplay()
    }
    
    private func updateDisplay() {
        // update the display value
        displayValue = brain.result
        
        // update the description
        descriptionLabel.text = brain.description
        descriptionLabel.text! += (brain.isPartialResult) ? " ..." : " ="
    }
    
    private func formatDisplayString(_ doubleValue: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 6
        return numberFormatter.string(from: NSNumber(floatLiteral: doubleValue))!
    }
    
    
    
    
}

