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
    private let ID:Int
    private let FbID:String
    private var Email:String
    private var Firstname:String
    private var Lastname:String
    private var ImageURL:String
    private var Password:String
    
    init(facebookId:String)
    {
        self.FbID = facebookId
        self.Firstname = ""
        self.Lastname = ""
        self.Email = ""
        self.ImageURL = ""
        self.Password = "Default"
        self.ID = 0
        
        let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(facebookId)/picture?width=150&length=150")
        if let data = NSData(contentsOfURL: facebookProfileUrl!)
        {
            self.ImageURL = EncodeImage(data)
        }
        
        let request = FBSDKGraphRequest(graphPath:"me", parameters: ["fields":"id,email,name"]);
        request.startWithCompletionHandler
            { (connection, result, error) -> Void in
                if error == nil
                {
                    let resultDict = result as! NSDictionary
                    self.Firstname = resultDict["name"] as! String
                    self.Email = resultDict["email"] as! String
                    
                }
        }
    }
    
    init(id:Int, fbId: String, email: String, firstname: String, lastname: String, imageURL: String, password: String){
        self.ID = id
        self.FbID = fbId
        self.Firstname = firstname
        self.Lastname = lastname
        self.Email = email
        self.ImageURL = imageURL
        self.Password = password
        
    }
    
    func getFacebookId() -> String{
        return self.FbID
    }
    func getId() -> Int{
        return self.ID
    }
    func getName() -> String{
        return self.Firstname + " " + self.Lastname
    }
    func getEmail() ->String{
        return self.Email
    }
    func getProfilePicture() -> UIImage{
        return DecodeImage()
    }
    func login() -> Bool{
        return false
    }
    private func EncodeImage(img:NSData)-> String{
        let base64String = img.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        return base64String
    }
    private func DecodeImage() -> UIImage{
        let decodedData = NSData(base64EncodedString: self.ImageURL, options: NSDataBase64DecodingOptions(rawValue: 0))
        let decodedimage = UIImage(data: decodedData!)
        print(decodedimage)
        return decodedimage! as UIImage
    }
}