//
//  ViewController.swift
//  calculatorHW
//
//  Created by Amber Spadafora on 8/5/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var calculatorEngine = CalculatorEngine()
    private var userIsCurrentlyTyping = false
    private var userIsEnteringADouble = false
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var displayValue: Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsCurrentlyTyping {
            let textCurrentlyInDisplay = displayLabel.text!
            displayLabel.text! = textCurrentlyInDisplay + digit
        } else {
            userIsCurrentlyTyping = true
            displayLabel.text = digit
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsCurrentlyTyping {
            calculatorEngine.setOperand(displayValue)
        }
        userIsCurrentlyTyping = false
        userIsEnteringADouble = false
        if let mathSymbol = sender.currentTitle {
            calculatorEngine.performOperation(mathSymbol)
        }
        if let result = calculatorEngine.result {
            displayValue = result
        }
    }
    
    
    @IBAction func clearButtonTouched(_ sender: UIButton) {
        displayLabel.text = "0"
        userIsEnteringADouble = false
        userIsCurrentlyTyping = false
    }
    
    @IBAction func decimalButtonTouched(_ sender: UIButton) {
        userIsCurrentlyTyping = true
        let textCurrentlyInDisplay = displayLabel.text!
        if !userIsEnteringADouble {
            displayLabel.text! = textCurrentlyInDisplay + "."
        }
        userIsEnteringADouble = true
    }
    
    
    
}

