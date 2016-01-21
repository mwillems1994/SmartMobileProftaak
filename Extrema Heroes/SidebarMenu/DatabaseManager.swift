//
//  DatabaseManager.swift
//  Extrema Heroes
//
//  Created by Fhict on 11/12/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit
import Foundation
typealias ServiceResponse = (JSON,NSError?) -> Void


class DatabaseManager:NSObject {
    static let sharedInstance = DatabaseManager()
    private let apiURL:String = "https://extremaheroes-extrema.rhcloud.com/"
    
    
     func executePost(id: String, value: String){
        let request = NSMutableURLRequest(URL: NSURL(string: self.apiURL)!)
        request.HTTPMethod = "POST"
        let postString = "\(id)=\(value)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    func getRewardsForEvent(eventID : Int, onCompletion: (JSON) -> Void) {
        let route = self.apiURL + "?getAllRewardsForEvent=\(eventID)"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getCheckCredentials(email: String, password: String, onCompletion: (JSON) -> Void) {
        let jsonCredentials = "%7B%22Email%22:%22\(email)%22,%22Password%22:%22\(password)%22%7D"
        let route = self.apiURL + "?checkCredentials=\(jsonCredentials)"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getAccountFromEmail(email : String, onCompletion: (JSON) -> Void) {
        let route = self.apiURL + "?getAccountFromEmail=\(email)"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getPointsForAccount(eventID: Int, accountID: Int, onCompletion: (JSON) -> Void){
        let jsonAccountEvent = "%7B%22EventID%22:\(eventID),%22AccountID%22:\(accountID)%7D"
        let route = self.apiURL + "?getPointsForAccount=\(jsonAccountEvent)"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func createAccount(fbID: String, var email: String, firstname: String, lastname: String, password: String){
        email = email.stringByReplacingOccurrencesOfString("@", withString: "%40")
        let jsonAccount = "%7B%22FbID%22:%22\(fbID)%22,%22Email%22:%22\(email)%22,%22Firstname%22:%22\(firstname)%22,%22Lastname%22:%22\(lastname)%22,%22Password%22:%22\(password)%22%7D"
        executePost("insertAccount", value: jsonAccount)
    }
    
    func insertInvite(AccountMasterID: Int, AccountInvitedID: Int){
        let jsonValues = "%7B%22AccountMasterID%22:\(AccountMasterID),%22AccountInvitedID%22:\(AccountInvitedID)%7D"
        executePost("insertInvite", value: jsonValues)
    }
    
    private func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let url = NSURL(string: path)!
        let request = NSMutableURLRequest(URL:url)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
}


