//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Mike Vork on 12/20/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var accumulator = 0.0
    private var pending: PendingBinaryOperationInfo?
    private var savedOperands = ""
    private var currentOperand = ""
    private var internalProgram = [AnyObject]()
    
    private enum Operation {
        case Constant(Double)
        case NoOperandOperation( () -> Double )
        case UnaryOperation( (Double) -> Double )
        case BinaryOperation( (Double, Double) -> Double )
        case Equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "Rand" : Operation.NoOperandOperation( { Double(arc4random()) / Double(UINT32_MAX) } ),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "sin" : Operation.UnaryOperation(sin),
        "tan" : Operation.UnaryOperation(tan),
        "log" : Operation.UnaryOperation(log),
        "±" : Operation.UnaryOperation( { -$0 } ),
        "×" : Operation.BinaryOperation( { $0 * $1 } ),
        "÷" : Operation.BinaryOperation( { $0 / $1 } ),
        "+" : Operation.BinaryOperation( { $0 + $1 } ),
        "−" : Operation.BinaryOperation( { $0 - $1 } ),
        "=" : Operation.Equals
    ]
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private func addValueSymbol(_ symbol: String) {
        currentOperand = symbol
        if !isPartialResult {
            savedOperands = ""
        }
    }
    
    private func processConstant(_ value: Double, symbol: String) {
        addValueSymbol(symbol)
        accumulator = value
    }
    
    private func processNoOperandOperation(_ symbol: String, function: () -> Double ) {
        addValueSymbol(symbol)
        accumulator = function()
    }
    
    
    private func formatNumericString(_ stringValue: String) -> String {
        if let doubleValue = Double(stringValue) {
            return formatNumericString(doubleValue)
        } else {
            return stringValue
        }
    }
    
    private func formatNumericString(_ doubleValue: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 6
        return numberFormatter.string(from: NSNumber(floatLiteral: doubleValue))!
    }
    
    
    // MARK: public interface
    var description: String {
        return savedOperands.concatenateWithTrimming(currentOperand)
    }
    
    var isPartialResult: Bool {
        return pending != nil
    }
    
    typealias PropertyList = AnyObject
    var program: PropertyList {
        get {
            return internalProgram as CalculatorBrain.PropertyList
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand: operand)
                    } else if let operationOrVariable = op as? String {
                        if operations[operationOrVariable] != nil {
                            performOperation(symbol: operationOrVariable)
                        } else {
                            setOperand(variableName: operationOrVariable)
                        }
                    }
                }
            }
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    var variableValues: Dictionary<String, Double> = [:]
    
    
    func clear() {
        pending = nil
        accumulator = 0.0
        currentOperand = ""
        savedOperands = ""
        internalProgram.removeAll()
    }
    
    func performOperation(symbol: String) {
        internalProgram.append(symbol as AnyObject)
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                processConstant(value, symbol: symbol)
            case .NoOperandOperation(let function):
                processNoOperandOperation(symbol, function: function)
            case .UnaryOperation(let function):
                let trimmedOperand = currentOperand.trimmingCharacters(in: .whitespaces)
                if trimmedOperand != "" {
                    currentOperand = "\(symbol)(\(formatNumericString(trimmedOperand)))"
                }
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                if currentOperand == "" {
                    currentOperand = formatNumericString(accumulator)
                }
                savedOperands = savedOperands.concatenateWithTrimming("\(formatNumericString(currentOperand)) \(symbol)")
                currentOperand = ""
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function,
                                                     firstOperand: accumulator)
            case .Equals:
                if currentOperand == "" {
                    currentOperand = formatNumericString(accumulator)
                }
                executePendingBinaryOperation()
                currentOperand = savedOperands.concatenateWithTrimming(formatNumericString(currentOperand))
                savedOperands = ""
            }
        }
    }
    
    func setOperand(operand: Double) {
        internalProgram.append(operand as AnyObject)
        if !isPartialResult {
            savedOperands = ""
            currentOperand = formatNumericString(operand)
        } else {
            currentOperand = formatNumericString(currentOperand.concatenateWithTrimming("\(operand)"))
        }
        accumulator = operand
    }
    
    func setOperand(variableName: String) {
        internalProgram.append(variableName as AnyObject)
        let operand = variableValues[variableName] ?? 0.0
        if !isPartialResult {
            savedOperands = ""
            currentOperand = variableName
        } else {
            currentOperand = formatNumericString(currentOperand.concatenateWithTrimming("\(variableName)"))
        }
        accumulator = operand
    }
}
