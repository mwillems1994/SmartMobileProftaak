//
//  ViewController.swift
//  fbLoginTest
//
//  Created by Fhict on 08/10/15.
//  Copyright (c) 2015 Robin. All rights reserved.
//


import UIKit
import FBSDKCoreKit
//#import <Frameworks/FBSDKShareKit.h>
import FBSDKLoginKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad()
    {
        if(FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Niet ingelogd");
        }
        else
        {
            print("Al ingelogd");
            //go to after login screen:
            self.performSegueWithIdentifier("loginSuccess", sender:self)
        }
        
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = [ "public_profile", "email", "user_friends"]
        loginButton.center = self.view.center
        loginButton.delegate = self
        
        self.view.addSubview(loginButton)
    }
    
    override func viewDidAppear(animated: Bool) {
        if(FBSDKAccessToken.currentAccessToken() != nil)
        {
            
            self.performSegueWithIdentifier("loginSuccess", sender:self)
            
            //returnUserData()
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
            
            //self.performSegueWithIdentifier("loginSuccess", sender:self)
            //print("hoi0")
            //returnUserData()
            //print("hoi1")
            /*
            var fbRequest = FBSDKGraphRequest(graphPath:"/me/friends", parameters: nil);
            fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
                if result == nil
                {
                    print("no results")
                }
                if error == nil {
                    
                    print("Friends are : \(result)")
                    
                } else {
                    
                    print("Error Getting Friends \(error)");
                    
                }
            }*/
            /*
            print("hoi")
            var request = FBSDKGraphRequest(graphPath:"me/friends", parameters: ["fields":"name"]);
            
            request.startWithCompletionHandler { (connection, result, error) -> Void in
                if error == nil {
                    print("Friends are : \(result)")
                } else {
                    print("Error Getting Friends \(error)");
                }
            }*/
            
        }
        else
        {
            print(error.localizedDescription);
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("Uitgelogd")
    }
    
    /*
    func getFriendsList() -> NSDictionary
    {
        let request = FBSDKGraphRequest(graphPath:"me/friends", parameters: ["fields":"name"]);
        var rresult:NSDictionary
        
        request.startWithCompletionHandler { (connection, result, error) -> Void in
            if error == nil {
                print("Friends are : \(result)")
                rresult = result as! NSDictionary
                return rresult;
            } else {
                print("Error Getting Friends \(error)");
                
            }
            
    }*/
    /*
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name,id"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }*/

}

