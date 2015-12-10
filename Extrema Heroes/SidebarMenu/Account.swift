//
//  Account.swift
//  Extrema Heroes
//
//  Created by Fhict on 10/12/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class Account
{
    private let id:Int
    private let facebookId:String
    private var email:String
    private var name:String
    private let profilePicture:UIImage
    
    init(facebookId:String)
    {
        self.facebookId = facebookId
        self.name = ""
        self.email = ""
        self.id = 0
        
        let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(self.id)/picture?width=150&length=150")
        if let data = NSData(contentsOfURL: facebookProfileUrl!)
        {
            self.profilePicture = UIImage(data: data)!
        }
        else
        {
            self.profilePicture = UIImage()
        }
        
        let request = FBSDKGraphRequest(graphPath:"me", parameters: ["fields":"id,email,name"]);
        request.startWithCompletionHandler
            { (connection, result, error) -> Void in
                if error == nil
                {
                    let resultDict = result as! NSDictionary
                    self.name = resultDict["name"] as! String
                    self.email = resultDict["email"] as! String
                }
        }
    }
    
    func getFacebookId() -> String{
        return self.facebookId
    }
    func getId() -> Int{
        return self.id
    }
    func getName() -> String{
        return self.name
    }
    func getEmail() ->String{
        return self.email
    }
    func getProfilePicture() -> UIImage{
        return self.profilePicture
    }
}