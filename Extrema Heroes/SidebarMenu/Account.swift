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
    init(facebookId:String)
    {
        var id = 0
        
        let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(facebookId)/picture?width=150&length=150")
        if let data = NSData(contentsOfURL: facebookProfileUrl!)
        {
            let imageURL = EncodeImage(data)
            NSUserDefaults.standardUserDefaults().setObject(imageURL, forKey: "ExtremaImageURL")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        let request = FBSDKGraphRequest(graphPath:"me", parameters: ["fields":"id,email,name"]);
        request.startWithCompletionHandler
            { (connection, result, error) -> Void in
                if error == nil
                {
                    let resultDict = result as! NSDictionary
                    
                    let newstr = resultDict["name"] as! String
                    let token = newstr.componentsSeparatedByString(" ")
                    print (token)
                    let firstname = token[0]
                    let lastname = token[1]
                    let email = resultDict["email"] as! String
                    
                    NSUserDefaults.standardUserDefaults().setObject(firstname, forKey: "ExtremaFirstname")
                    NSUserDefaults.standardUserDefaults().setObject(lastname, forKey: "ExtremaLastname")
                    NSUserDefaults.standardUserDefaults().setObject(email, forKey: "ExtremaEmail")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
        }
        NSUserDefaults.standardUserDefaults().setObject(facebookId, forKey: "ExtremaFbId")
        NSUserDefaults.standardUserDefaults().setObject(id, forKey: "ExtremaId")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    init(id:Int, fbId: String, email: String, firstname: String, lastname: String, imageURL: String, password: String){
        NSUserDefaults.standardUserDefaults().setObject(id, forKey: "ExtremaId")
        NSUserDefaults.standardUserDefaults().setObject(fbId, forKey: "ExtremaFbId")
        NSUserDefaults.standardUserDefaults().setObject(firstname, forKey: "ExtremaFirstname")
        NSUserDefaults.standardUserDefaults().setObject(lastname, forKey: "ExtremaLastname")
        NSUserDefaults.standardUserDefaults().setObject(email, forKey: "ExtremaEmail")
        NSUserDefaults.standardUserDefaults().setObject(imageURL, forKey: "ExtremaImageURL")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    init(){
        
    }
    
    func getFacebookId() -> String{
        return NSUserDefaults.standardUserDefaults().objectForKey("ExtremaFbId") as! String
    }
    func getId() -> Int{
        return NSUserDefaults.standardUserDefaults().objectForKey("ExtremaId") as! Int
    }
    func getName() -> String{
         let fn = NSUserDefaults.standardUserDefaults().objectForKey("ExtremaFirstname") as! String
         let ln = NSUserDefaults.standardUserDefaults().objectForKey("ExtremaLastname") as! String
        return fn + " " + ln
    }
    func getEmail() ->String{
        return NSUserDefaults.standardUserDefaults().objectForKey("ExtremaEmail") as! String
    }
    func getProfilePicture() -> UIImage{
        return DecodeImage()
    }
    func setProfilePicture(data:NSData){
        let imageURL = EncodeImage(data)
        NSUserDefaults.standardUserDefaults().setObject(imageURL, forKey: "ExtremaImageURL")
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    private func EncodeImage(img:NSData)-> String{
        let base64String = img.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        return base64String
    }
    private func DecodeImage() -> UIImage{
        let imageURL = NSUserDefaults.standardUserDefaults().objectForKey("ExtremaImageURL") as! String
        let decodedData = NSData(base64EncodedString: imageURL, options: NSDataBase64DecodingOptions(rawValue: 0))
        let decodedimage = UIImage(data: decodedData!)
        return decodedimage! as UIImage
    }
}