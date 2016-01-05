//
//  RegisterViewController.swift
//  Extrema Heroes
//
//  Created by Marco Willems on 13/12/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import Foundation

class RegisterViewController: UIViewController {
    @IBOutlet weak var tbFirstname: UITextField!
    @IBOutlet weak var tbLastname: UITextField!
    @IBOutlet weak var tbEmail: UITextField!
    @IBOutlet weak var tbPassword: UITextField!
    
    @IBAction func btnCreateAccount(sender: UIButton) {
        DatabaseManager.sharedInstance.createAccount("", email: tbEmail.text!, firstname: tbFirstname.text!, lastname: tbLastname.text!, password: tbPassword.text!)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

