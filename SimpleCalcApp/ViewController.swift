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
    var decimal : Bool = false
    
    @IBOutlet weak var textBox: UITextField!
    
    
    @IBAction func numberButtonPress(sender: UIButton) {
        textBox.text! += "\(sender.currentTitle!)"
        currOperand.append(sender.currentTitle!.toInt()!)
    }
    
    @IBAction func decimalButtonPress(sender: UIButton) {
        textBox.text = "\(sender.currentTitle!) decimal pressed"
    }
    
    @IBAction func basicFuncButtonPress(sender: UIButton) {
        var op : Op = Op.error
        
        switch sender.currentTitle! {
        case "+": op = Op.add
        case "-": op = Op.sub
        case "x": op = Op.mul
        case "/": op = Op.div
        default: op = Op.error
        }
        
        var operand = parseOperand()
        
        operators.append(op)
        operands.append(operand)
        
        populateTextBox()
    }
    
    @IBAction func complexFuncButtonPress(sender: UIButton) {
        textBox.text = "\(sender.currentTitle!) complex func pressed"
    }
    
    @IBAction func rpnButtonPress(sender: UIButton) {
        textBox.text = "\(sender.currentTitle!) rpn pressed"
    }
    
    
    @IBAction func equalButtonPress(sender: UIButton) {
        textBox.text = "\(sender.currentTitle!) equals pressed."
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
    
    func populateTextBox() {
        var text = ""
        for var i = 0; i < operands.count; i++ {
            text += "\(operands[i]) "
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
        
        textBox.text = text
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

