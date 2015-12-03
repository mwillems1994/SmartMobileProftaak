//
//  Friend.swift
//  fbLoginTest
//
//  Created by Fhict on 21/10/15.
//  Copyright © 2015 Jense Schouten. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookAccount
{
    private let id:String
    private var name:String
    private let profilePicture:UIImage
    
    init(id:String)
    {
        self.id = id
        self.name = ""
        
        let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(self.id)/picture?width=150&length=150")
        if let data = NSData(contentsOfURL: facebookProfileUrl!)
        {
            self.profilePicture = UIImage(data: data)!
        }
        else
        {
            self.profilePicture = UIImage()
        }
        let request = FBSDKGraphRequest(graphPath:"me", parameters: ["fields":"id,name"]);
        request.startWithCompletionHandler
            { (connection, result, error) -> Void in
            if error == nil
            {
                let resultDict = result as! NSDictionary
                self.name = resultDict["name"] as! String
            }
        }
    }
    func getId() -> String{
         return self.id
    }
    func getName() -> String{
            return self.name
    }
    func getProfilePicture() -> UIImage{
            return self.profilePicture
    }
}