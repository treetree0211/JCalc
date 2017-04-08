//
//  ViewController.swift
//  JCalc
//
//  Created by Janet Zhang on 4/5/17.
//  Copyright © 2017 Janet Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var display: UILabel!
    
    var userIntheMiddleofTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        //print("\(digit) was called")
        if userIntheMiddleofTyping {
            let textCurrentlyInDisplay = display!.text!
            display!.text = textCurrentlyInDisplay + digit
        }else {
            display!.text = digit
            userIntheMiddleofTyping = true
        }
    }
    
    // convert string to double and then double to string
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    // connect with model
    private var model = CalculatorModel()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIntheMiddleofTyping {
            model.setOperand(displayValue)
            userIntheMiddleofTyping = false
        }
        
        if let mathmeticalSymbol = sender.currentTitle {
            model.performOperation(mathmeticalSymbol)
        }
        
        //displayValue = model.result!
        if let result = model.result {
            displayValue = result
        }
    }

}

