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

struct myAccount {
    static var me:Account!
}
class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad()
    {
        requireFacebook()
    }
    
    
    func requireFacebook(){
        if(FBSDKAccessToken.currentAccessToken() != nil) {
            print("Al ingelogd");
            myAccount.me = Account(facebookId: FBSDKAccessToken.currentAccessToken().userID)
            self.performSegueWithIdentifier("loginSuccess", sender:self)
        }
        
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = [ "public_profile", "email", "user_friends"]
        let X_Pos:CGFloat? = (self.view.frame.width * 0.5) - (loginButton.frame.width / 2)
        let Y_Pos:CGFloat? = (self.view.frame.height * 0.546) + loginButton.frame.height
        
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

