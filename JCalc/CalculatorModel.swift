//
//  CalculatorModel.swift
//  JCalc
//
//  Created by Janet Zhang on 4/6/17.
//  Copyright © 2017 Janet Zhang. All rights reserved.
//

import Foundation

func multiply(op1: Double, op2: Double)  {
    var operationStack = Stack<Double>()
    let value = op1 * op2
    
    print(value)
    operationStack.push(value)
    
}
    

//store multiple operation, push
struct Stack<Double> {
    fileprivate var array: [Double] = []
    
    mutating func push(_ element: Double) {
        array.append(element)
    }
    
    mutating func pop() -> Double? {
        return array.popLast()
    }
    
    func peek() -> Double? {
        return array.last
    }
    
}



struct CalculatorModel {
    private var accumulator: Double?
    private var equalIsPressed = false
    
    private enum Operation {
        case constant(Double)
        //unaryoperation associated with function
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double)->(Double))
        case equals
    }
    
    private var operations: Dictionary<String, Operation>=
    [ "π": Operation.constant(Double.pi),
      "e": Operation.constant(M_E),
      "√": Operation.unaryOperation(sqrt),
      "cos": Operation.unaryOperation(cos),
      "sin": Operation.unaryOperation(sin),
      "tan": Operation.unaryOperation(tan),
      // closure: funtion in line, see changesign above
      "±": Operation.unaryOperation({-$0}),
      "×": Operation.binaryOperation({$0 * $1}),
      "=": Operation.equals,
      "+": Operation.binaryOperation({$0 + $1}),
      "-": Operation.binaryOperation({$0 - $1}),
      "÷": Operation.binaryOperation({$0 / $1}),
      "%": Operation.unaryOperation({0.01 * $0})
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBianryOperation(function: function, firstOperand: accumulator!)
                    print("function \(function)")
                    accumulator = nil
                }
            case .equals:
                equalIsPressed = true;
                performPendingBinaryOperation()
            }
        }
        
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBianryOperation?
    
    // data structrue for storing second binary operand, data structure can store vars and methods 
    private struct PendingBianryOperation {
        let function: (Double, Double) -> (Double)
        let firstOperand: Double
        
       func perform(with secondOperand: Double) -> Double {
            
           return  function(firstOperand, secondOperand)
        
//            var performStack = Stack<Double>()
//            let value = performStack.array.popLast()!
//            print("pop \(value)")
//            return 0.0
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        print("operand \(accumulator!)")
    }
    
    // may return number or operation sign "+"
    var result: Double? {
        get{
            return accumulator
        }
    }
    
    
}
