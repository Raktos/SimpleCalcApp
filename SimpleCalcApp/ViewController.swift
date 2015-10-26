//
//  ViewController.swift
//  SimpleCalcApp
//
//  Created by iGuest on 10/22/15.
//  Copyright (c) 2015 Jason Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textBox: UITextField!
    
    
    @IBAction func numberButtonPress(sender: UIButton) {
        textBox.text = "\(sender.currentTitle!) num pressed"
    }
    
    @IBAction func decimalButtonPress(sender: UIButton) {
        textBox.text = "\(sender.currentTitle!) decimal pressed"
    }
    
    @IBAction func basicFuncButtonPress(sender: UIButton) {
        textBox.text = "\(sender.currentTitle!) basic func pressed"
    }
    
    @IBAction func complexFuncButtonPress(sender: UIButton) {
        textBox.text = "\(sender.currentTitle!) complex func pressed"
    }
    
    @IBAction func rpnButtonPress(sender: UIButton) {
        textBox.text = "\(sender.currentTitle!) rpn pressed"
    }
    
    
    @IBAction func equalButtonPress(sender: UIButton) {
        textBox.text = "\(sender.currentTitle!) equals pressed"
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

