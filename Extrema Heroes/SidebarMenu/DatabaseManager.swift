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
    
    func getJson(onCompletion: (JSON) -> Void) {
        let route = self.apiURL
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getRewardsForEvent(eventID : Int, onCompletion: (JSON) -> Void) {
        let route = self.apiURL + "?getAllRewardsForEvent=\(eventID)"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    private func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
}


