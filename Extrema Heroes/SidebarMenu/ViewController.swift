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
    let account = Account()
    @IBAction func btnSubmit(sender: UIButton) {
        let barcode = self.DecodeString(tbCode.text!)
        let splittedBarcode = barcode.characters.split{$0 == "_"}.map(String.init)
        let accountMasterID = Int(splittedBarcode[1])
        account.setTempInvite(accountMasterID!)
    }
    
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
        let utf8str = barcode.dataUsingEncoding(NSUTF8StringEncoding)
        let base64Encoded = utf8str!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        self.tbCode.text! = base64Encoded
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BarcodeScanner"{
            let barcodeViewController: BarcodeViewController = segue.destinationViewController as! BarcodeViewController
            barcodeViewController.delegate = self
        }
    }
    
    private func EncodeString(barcode: String)-> String{
        let utf8str = barcode.dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = utf8str!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        return base64String
    }
    private func DecodeString(encodedString: String) -> String{
        let decodedData = NSData(base64EncodedString: encodedString, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
        let decodedString = NSString(data: decodedData, encoding: NSUTF8StringEncoding)!
        return String(decodedString)
    }
    
}


