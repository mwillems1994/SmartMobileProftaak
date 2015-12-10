//
//  ViewController.swift
//  QRTest
//
//  Created by Marco Willems on 08/12/15.
//  Copyright © 2015 ExtremaHeroes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BarcodeDelegate {
    
    @IBOutlet weak var TextOutput: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func barcodeReaded(barcode: String) {
        TextOutput.text = barcode
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the destination view controller
        let barcodeViewController: BarcodeViewController = segue.destinationViewController as! BarcodeViewController
        
        barcodeViewController.delegate = self;
    }

}

