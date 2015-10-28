//
//  ViewController.swift
//  SimpleCalcApp
//
//  Created by iGuest on 10/22/15.
//  Copyright (c) 2015 Jason Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Op{
        case add, sub, mul, div, ave, count, fact, error
    }
    
    var operands : [Double] = []
    var operators : [Op] = []
    var currOperand : [Int] = []
    var decimalOperand : Double = 0.0
    var decimal : Bool = false
    var typing : Bool = true
    var clearable : Bool = false
    
    @IBOutlet weak var textBox: UITextField!
    
    
    @IBAction func numberButtonPress(sender: UIButton) {
        textBox.text! += "\(sender.currentTitle!)"
        currOperand.append(sender.currentTitle!.toInt()!)
    }
    
    @IBAction func decimalButtonPress(sender: UIButton) {
        decimalOperand = parseOperand()
        decimal = true
        textBox.text! += "."
    }
    
    @IBAction func basicFuncButtonPress(sender: UIButton) {
        if operators.count == 0 || operators[0] == Op.add || operators[0] == Op.sub || operators[0] == Op.div || operators[0] == Op.mul {
            var op : Op = Op.error
            
            switch sender.currentTitle! {
            case "+": op = Op.add
            case "-": op = Op.sub
            case "x": op = Op.mul
            case "/": op = Op.div
            default: op = Op.error
            }
            
            if typing {
                operands.append(decimalOperand + parseOperand())
            }
            
            if operators.count != 0 {
                //we already had an operator, we need to do an operation before adding our new one
                performOperation()
            }
            
            operators.append(op)
            typing = true
            populateTextBox()
        }
    }
    
    @IBAction func aveButtonPress(sender: UIButton) {
        if operators.count == 0 || operators[0] == Op.ave {
            if typing {
                operands.append(decimalOperand + parseOperand())
            }
            
            operators.append(Op.ave)
            typing = true
            populateTextBox()
        }
    }
    
    @IBAction func countButtonPress(sender: UIButton) {
        if operators.count == 0 || operators[0] == Op.count {
            if typing {
                operands.append(decimalOperand + parseOperand())
            }
            
            operators.append(Op.count)
            typing = true
            populateTextBox()
        }
    }
    
    @IBAction func factButtonPress(sender: UIButton) {
        if operators.count == 0 {
            if typing {
                operands.append(decimalOperand + parseOperand())
            }
            
            operators.append(Op.fact)
            typing = true
            populateTextBox()
        }
    }
    
    @IBAction func equalButtonPress(sender: UIButton) {
        if typing {
            if currOperand.count > 0 {
                operands.append(decimalOperand + parseOperand())
            }
            switch operators[0] {
            case .add, .sub, .mul, .div:
                performOperation()
            case .ave:
                performAverage()
            case .count:
                performCount()
            case .fact:
                performFact()
            default:
                return
            }
            typing = false
            populateTextBox()
        }
        
    }
    
    @IBAction func clearButtonPress(sender: UIButton) {
        clear()
        populateTextBox()
    }
    
    func performOperation() {
        //for basic functions only
        let result = basicOperation(operands[0], right: operands[1], op: operators[0])
        
        if result == nil {
            return
        }
        
        clear()
        operands.append(result!)
    }
    
    func parseOperand() -> Double {
        var final : Double = 0.0
        var order : Double = 0.0
        if decimal {
            order = 0.1
        } else {
            order = 1.0
            for var i = 1; i < currOperand.count; i++ {
                order *= 10.0
            }
        }
        
        for n in currOperand {
            final += (Double(n) * order)
            order /= 10.0
        }
        
        currOperand = []
        return final
    }
    
    func divByZero() {
        clear()
        clearable = true
        textBox.text! = "Cannot divide by 0"
    }
    
    func populateTextBox() {
        var text = ""
        for var i = 0; i < operands.count; i++ {
            text += "\(operands[i]) "
            
            if operators.count > 0 {
                switch operators[i] {
                case .add: text += "+ "
                case .sub: text += "- "
                case .mul: text += "x "
                case .div: text += "/ "
                case .count: text += "count "
                case .ave: text += "ave "
                case .fact: text += "fact "
                default: text += "ERROR"
                }
            }
        }
        
        textBox.text = text
    }
    
    func basicOperation(left : Double, right : Double, op : Op) -> Double? {
        switch op {
        case .add: return left + right
        case .sub: return left - right
        case .mul: return left * right
        case .div: if right == 0 {return nil} else {return left / right}
        default: return nil
        }
    }
    
    func clear() {
        operands = []
        operators = []
        currOperand = []
        decimal = false
        typing = true
        clearable = false
        decimalOperand = 0.0
        textBox.text = ""
    }
    
    func performAverage() {
        var result : Double = 0.0
        for n in operands {
            result += n
        }
        
        result = result / Double(operands.count)
        
        clear()
        operands.append(result)
    }
    
    func performCount() {
        var result = Double(operands.count)
        
        clear()
        operands.append(result)
    }
    
    func performFact() {
        var counter = operands[0] - 1
        var result = operands[0]
        
        while counter > 0 {
            result *= counter
            counter--
        }
        
        clear()
        operands.append(result)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

