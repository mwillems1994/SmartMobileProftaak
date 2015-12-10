//
//  ViewController.swift
//  CreateAccount
//
//  Created by Marco Willems on 09/12/15.
//  Copyright © 2015 ExtremaHeroes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tbFirstname: UITextField!
    
    @IBAction func btnCreateAccount(sender: UIButton) {
        print("tbEmail: \(tbFirstname.text)")
        Account.checkIfEmailInUse(tbFirstname.text!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Account.accounts = Account.getDemoAccounts()
        print(Account.accounts.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

