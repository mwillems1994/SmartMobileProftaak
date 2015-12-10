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
import FBSDKShareKit

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
        
        // migael toegevoegd
        // share button
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "http://google.nl")
        content.contentTitle = "Extrema Heroes"
        content.contentDescription = "test deel knop"
        content.imageURL = NSURL(string: "http://extremanetwork.com/wp-content/uploads/2015/02/extrema_logo.png")
        
        let shareButton : FBSDKShareButton = FBSDKShareButton()
        shareButton.shareContent = content
        shareButton.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 100) * 0.5, 50, 100, 25)
        self.view.addSubview(shareButton)
        // tot hier
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