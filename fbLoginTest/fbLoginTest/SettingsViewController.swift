//
//  SettingsViewController.swift
//  E-vade
//
//  Created by Fhict on 04/11/15.
//  Copyright © 2015 Fhict. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class SettingsViewController:UIViewController, FBSDKLoginButtonDelegate {
    override func viewDidLoad()
    {
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = [ "public_profile", "email", "user_friends"]
        let X_Pos:CGFloat? = (self.view.frame.width * 0.5) - (loginButton.frame.width / 2)
        let Y_Pos:CGFloat? = (self.view.frame.height * 0.8) + loginButton.frame.height
        
        loginButton.frame = CGRectMake(X_Pos!, Y_Pos!, loginButton.frame.width, loginButton.frame.height)
        loginButton.delegate = self
        
        self.view.addSubview(loginButton)
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
        //Comment: to terminate app, do not use exit(0) bc that is logged as a crash.
        
        UIControl().sendAction(Selector("suspend"), to: UIApplication.sharedApplication(), forEvent: nil)
        
    }

}