//
//  ViewController.swift
//  Calculator
//
//  Created by Kamil Kowalski on 02/02/15.
//  Copyright (c) 2015 Kamil Kowalski. All rights reserved.
//

import UIKit;

class ViewController: UIViewController
{
    var userIsInTheMiddleOfTyping = false;
    
    var operandStack = Array<Double>();
    
    @IBOutlet weak var display: UILabel!;
    
    @IBAction func digitPressed(sender: UIButton)
    {
        let digit = sender.currentTitle!;
        if (self.userIsInTheMiddleOfTyping)
        {
            self.display.text? = display.text! + digit;
        }
        else
        {		
            self.userIsInTheMiddleOfTyping = true;
            self.display.text? = digit;
        }
    }
    
    @IBAction func operate(sender: UIButton)
    {
        let operation = sender.currentTitle!;
        if(self.userIsInTheMiddleOfTyping)
        {
            self.enter();
        }
        switch(operation)
        {
            case "×": performOperation({$0 * $1}); break;
            case "÷": performOperation({$1 / $0}); break;
            case "+": performOperation({$0 + $1}); break;
            case "−": performOperation({$1 - $0}); break;
            case "√": performOperation({sqrt($0)}); break;
            default: break;
        }
    }

    func performOperation(operation: Double -> Double)
    {
        if(self.operandStack.count >= 1)
        {
            self.displayValue = operation(self.operandStack.removeLast());
            self.enter();
        }
    }
 
    func performOperation(operation: (Double, Double) -> Double)
    {
        if(self.operandStack.count >= 2)
        {
            self.displayValue = operation(self.operandStack.removeLast(), self.operandStack.removeLast());
            self.enter();
        }
    }
    
    @IBAction func enter()
    {
        self.userIsInTheMiddleOfTyping = false;
        self.operandStack.append(self.displayValue);
        println("operandStack = \(operandStack)");
    }
    
    var displayValue : Double
    {
        get
        {
            return NSNumberFormatter().numberFromString(self.display.text!)!.doubleValue;
        }
        set
        {
            self.display.text = "\(newValue)";
            self.userIsInTheMiddleOfTyping = false;
        }
    }
    
}

