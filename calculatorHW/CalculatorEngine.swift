//
//  CalculatorEngine.swift
//  calculatorHW
//
//  Created by Amber Spadafora on 8/5/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

struct CalculatorEngine {
    
    private enum OperationTypes {
        case constant(Double)
        case binaryOperation((Double, Double) -> Double)
        case unaryOperation((Double) -> Double)
        case equals
        case clear
    }
    
    private var operations: Dictionary<String, OperationTypes> = [
        "√" : .unaryOperation(sqrt),
        "π" : .constant(Double.pi),
        "e" : .constant(M_E),
        "+" : .binaryOperation({ $0 + $1 }),
        "−" : .binaryOperation({ $0 - $1 }),
        "×" : .binaryOperation({ $0 * $1 }),
        "÷" : .binaryOperation({ $0 / $1 }),
        "^" : .binaryOperation({ pow($0, $1) }),
        "=" : .equals,
        "Clear" : .clear,
        "±" : .unaryOperation({ -$0 })
    ]
    
    // only performOperations func needs to see this
    private var accumulator: Double?
    
    // instance of pendingBinaryOperation structure
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        var function: (Double, Double) -> Double
        var firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    // Public API (accessible to view controller)
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let val):
                accumulator = val
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .equals:
                performBinaryOperation()
                break
            case .clear:
                accumulator = nil
                pendingBinaryOperation = nil
            }
        }
    }
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    mutating private func performBinaryOperation(){
        if accumulator != nil && pendingBinaryOperation != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    
    
    
}
