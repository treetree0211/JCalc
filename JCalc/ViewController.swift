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
        // call swift function
        // drawHorizotaline(from: 2.0, to: 3.4, using:UIColor.blue)
        // put the "!" will get the optional associate value string
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

    @IBAction func performOperation(_ sender: UIButton) {
        userIntheMiddleofTyping = false
        if let mathmeticalSymbol = sender.currentTitle {
            switch mathmeticalSymbol {
            case "π":
                displayValue = Double.pi
            case "√":
                displayValue = sqrt(displayValue)
            default:
                break
            }
        }
    }
// swift function
//    func drawHorizotaline(from startX:Double, to endX:Double, using color:UIColor) -> String {
//          distance = startX - endX
//    }
}

