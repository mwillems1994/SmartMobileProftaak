//
//  RegisterViewController.swift
//  Extrema Heroes
//
//  Created by Marco Willems on 13/12/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import Foundation

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tbFirstname: UITextField!
    @IBOutlet weak var tbPassword: UITextField!
    @IBOutlet weak var tbEmail: UITextField!
    @IBOutlet weak var tbLastname: UITextField!
    
    @IBAction func btnCreate(sender: UIButton) {
        DatabaseManager.sharedInstance.getAccountFromEmail(tbEmail.text!) { json in
            if(json.count > 0){
                for (_ , subJson): (String, JSON) in json {
                    let accountJson:JSON = JSON(subJson.object)
                    let id = Int(accountJson["ID"].string!)!
                    NSUserDefaults.standardUserDefaults().setObject(id, forKey: "ExtremaId")
                }
                NSUserDefaults.standardUserDefaults().synchronize()
            }else{
                DatabaseManager.sharedInstance.createAccount("", email: self.tbEmail.text!, firstname: self.tbFirstname.text!, lastname: self.tbLastname.text!, password: self.tbPassword.text!)
                sleep(1)
                DatabaseManager.sharedInstance.getAccountFromEmail(self.tbEmail.text!) { json in
                    for (_ , subJson): (String, JSON) in json {
                        let accountJson:JSON = JSON(subJson.object)
                        let _ = Account(
                            id: Int(accountJson["ID"].string!)!,
                            fbId: accountJson["FbID"].string!,
                            email: accountJson["Email"].string!,
                            firstname: accountJson["Firstname"].string!,
                            lastname: accountJson["Lastname"].string!,
                            imageURL: accountJson["ImageURL"].string!,
                            password: self.tbPassword.text!,
                            eventId: 1
                        )
                        DatabaseManager.sharedInstance.insertInvite(Int(accountJson["ID"].string!)!, AccountInvitedID: Int(accountJson["ID"].string!)!)
                        self.checkTempInvite()
                    }
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                sleep(1)
                self.performSegueWithIdentifier("loginSuccess", sender:self)
            }
        }
    }
    
    func checkTempInvite() {
        let account = Account()
        let tempInvite = account.getTempInvite()
        let tempID = account.getId()
        if(tempInvite != 0){
            if(tempInvite != tempID){
                DatabaseManager.sharedInstance.insertInvite(tempInvite, AccountInvitedID: tempID)
            }
            account.removeTempInvite()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tbEmail.delegate = self
        self.tbFirstname.delegate = self
        self.tbLastname.delegate = self
        self.tbPassword.delegate = self
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

