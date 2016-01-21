//
//  ViewController.swift
//  Extrema Heroes
//
//  Created by Kevin Borghmans on 08/12/15.
//  Copyright © 2015 Kevin Borghmans. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BarcodeDelegate {
@IBOutlet weak var tbCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Textfield Delegate
    
    func textFieldShouldReturn(textField: UITextField) ->Bool {
        
        textField.resignFirstResponder()
        textField.text = "hoi"
        
        return true;
        
    }
    
    func barcodeReaded(barcode: String) {
        self.tbCode.text? = "code: \(barcode)"
    }
    
}


