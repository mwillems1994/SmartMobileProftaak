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
                    
                    DatabaseManager.sharedInstance.getAccountFromEmail(email) { json in
                        if(json.count > 0){
                            for (_ , subJson): (String, JSON) in json {
                                let accountJson:JSON = JSON(subJson.object)
                                let id = Int(accountJson["ID"].string!)!
                                NSUserDefaults.standardUserDefaults().setObject(id, forKey: "ExtremaId")
                            }
                            NSUserDefaults.standardUserDefaults().synchronize()
                        
                        }else{
                            DatabaseManager.sharedInstance.createAccount(facebookId, email: email, firstname: firstname, lastname: lastname, password: "fAcEbO0kAP1L0g1N")
                            sleep(1)
                            DatabaseManager.sharedInstance.getAccountFromEmail(email) { json in
                                for (_ , subJson): (String, JSON) in json {
                                    let accountJson:JSON = JSON(subJson.object)
                                    let id = Int(accountJson["ID"].string!)!
                                    NSUserDefaults.standardUserDefaults().setObject(id, forKey: "ExtremaId")
                                    DatabaseManager.sharedInstance.insertInvite(id, AccountInvitedID: id)
                                    self.checkTempInvite()
                                }
                                NSUserDefaults.standardUserDefaults().synchronize()
                            }
                        }
                    }
                }
        }
        NSUserDefaults.standardUserDefaults().setObject(facebookId, forKey: "ExtremaFbId")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    init(id:Int, fbId: String, email: String, firstname: String, lastname: String, imageURL: String, password: String, eventId: Int){
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
    
    private func checkTempInvite() {
        let tempInvite = self.getTempInvite()
        let tempID = self.getId()
        if(tempInvite != 0){
            if(tempInvite != tempID){
                DatabaseManager.sharedInstance.insertInvite(tempInvite, AccountInvitedID: tempID)
            }
            self.removeTempInvite()
        }
    }
    
    func getPointsFromDB(EventID: Int, AccountID: Int) -> Int{
        var tempPoints = 0
        DatabaseManager.sharedInstance.getPointsForAccount(1, accountID: getId()) { json in
            for (_ , subJson): (String, JSON) in json {
                let pointsJson:JSON = JSON(subJson.object)
                let points = Int(pointsJson["Points"].string!)
                tempPoints = points!
            }
        }
        sleep(1)
        return tempPoints
    }
    
    func getId() -> Int{
        if (NSUserDefaults.standardUserDefaults().objectForKey("ExtremaId") != nil){
            return NSUserDefaults.standardUserDefaults().objectForKey("ExtremaId") as! Int
        }
        return 0
    }
    
    func setTempInvite(accountMasterID: Int){
        NSUserDefaults.standardUserDefaults().setObject(accountMasterID, forKey: "ExtremaTempInviteAccountMasterID")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getTempInvite() -> Int {
        if (NSUserDefaults.standardUserDefaults().objectForKey("ExtremaTempInviteAccountMasterID") != nil){
            return NSUserDefaults.standardUserDefaults().objectForKey("ExtremaTempInviteAccountMasterID") as! Int
        }
        return 0
    }
    
    func removeTempInvite(){
        NSUserDefaults.standardUserDefaults().removeObjectForKey("ExtremaTempInviteAccountMasterID")
    }
    
    func getPoints(EventId:Int) -> Int{
        let points = getPointsFromDB(EventId, AccountID: getId())
        if(NSUserDefaults.standardUserDefaults().objectForKey("ExtremaPoints") != nil){
            if((NSUserDefaults.standardUserDefaults().objectForKey("ExtremaPoints") as! Int) < points){
                NSUserDefaults.standardUserDefaults().setObject(points, forKey: "ExtremaPoints")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }else{
            NSUserDefaults.standardUserDefaults().setObject(points, forKey: "ExtremaPoints")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        return NSUserDefaults.standardUserDefaults().objectForKey("ExtremaPoints") as! Int
    }
    
    func getFacebookId() -> String{
        return NSUserDefaults.standardUserDefaults().objectForKey("ExtremaFbId") as! String
    }
        
    func getName() -> String{
        if(NSUserDefaults.standardUserDefaults().objectForKey("ExtremaFirstname") != nil){
         let fn = NSUserDefaults.standardUserDefaults().objectForKey("ExtremaFirstname") as! String
         let ln = NSUserDefaults.standardUserDefaults().objectForKey("ExtremaLastname") as! String
        return fn + " " + ln
        }
        return ""
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
        if(NSUserDefaults.standardUserDefaults().objectForKey("ExtremaImageURL") == nil){
            return UIImage(named: "main_photo_profile")!
        }
        
        let imageURL = NSUserDefaults.standardUserDefaults().objectForKey("ExtremaImageURL") as! String
        if(imageURL.isEmpty || imageURL == " "){
            return UIImage(named: "main_photo_profile")!
        }
        
        let decodedData = NSData(base64EncodedString: imageURL, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let decodedimage = maskRoundedImage(UIImage(data: decodedData!)!, radius: 80)
        return decodedimage
    }
    
    private func maskRoundedImage(image: UIImage, radius: Float) -> UIImage {
        let imageView: UIImageView = UIImageView(image: image)
        var layer: CALayer = CALayer()
        layer = imageView.layer
        
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(radius)
        
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage
    }
}