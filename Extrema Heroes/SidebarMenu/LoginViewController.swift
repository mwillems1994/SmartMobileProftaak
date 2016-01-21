//
//  loginViewController.swift
//  Extrema Heroes
//
//  Created by Fhict on 10/12/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var tbPassword: UITextField!
    @IBOutlet weak var tbUsername: UITextField!
    @IBAction func btnLogin(sender: UIButton) {
        var credentialCheck = false;
        DatabaseManager.sharedInstance.getCheckCredentials(tbUsername.text!, password: tbPassword.text!) { json in
            for (_, subJson): (String, JSON) in json {
                let response:JSON = JSON(subJson.object)
                if(response == true){
                    credentialCheck = true
                } else {
                    credentialCheck = false
                    print("Inloggegevens verkeerd")
                }
            }
        }
        sleep(1)
        if(credentialCheck == true){
            DatabaseManager.sharedInstance.getAccountFromEmail(tbUsername.text!) { json in
                for (_, subJson): (String, JSON) in json {
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
                }
            }
            sleep(1)
            self.performSegueWithIdentifier("loginSuccess", sender:self)
        }
    }
    
    override func viewDidLoad()
    {
        requireFacebook()
        self.tbUsername.delegate = self
        self.tbPassword.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func requireFacebook(){
        if(FBSDKAccessToken.currentAccessToken() != nil) {
            print("Al ingelogd");
            _ = Account(facebookId: FBSDKAccessToken.currentAccessToken().userID)
            sleep(1)
            self.performSegueWithIdentifier("loginSuccess", sender:self)
        }
        
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = [ "public_profile", "email", "user_friends"]
        let X_Pos:CGFloat? = (self.view.frame.width * 0.5) - (loginButton.frame.width / 2)
        let Y_Pos:CGFloat? = 350
        loginButton.frame = CGRectMake(X_Pos!, Y_Pos!, loginButton.frame.width, loginButton.frame.height)
        loginButton.delegate = self
        
        self.view.addSubview(loginButton)
    }
    
    override func viewDidAppear(animated: Bool) {
        if(FBSDKAccessToken.currentAccessToken() != nil)
        {
            self.performSegueWithIdentifier("loginSuccess", sender:self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error == nil
        {
            print("Ingelogd")
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("Uitgelogd")
    }
}


