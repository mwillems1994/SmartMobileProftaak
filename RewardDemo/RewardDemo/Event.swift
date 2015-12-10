//
//  Event.swift
//  RewardDemo
//
//  Created by Marco Willems on 09/12/15.
//  Copyright © 2015 ExtremaHeroes. All rights reserved.
//

import Foundation
public class Event : CustomStringConvertible{
    public var description: String { return "ID: \(ID), Name: \(Name), Active: \(Active)" }
    var ID : Int!
    var Name : String!
    var Active : String!
    var Rewards : [Reward] = []
    
    init(ID : Int, Name : String, Active : String){
        self.ID = ID
        self.Name = Name
        self.Active = Active
        self.Rewards = [Reward]()
        updateIP()
    }
    
    private func getRewards(){
            RestApiManager.sharedInstance.getRewardsForEvent(1) { json in
                for (index, subJson): (String, JSON) in json {
                    let rewardJSON:JSON = JSON(subJson.object)
                    let tempReward:Reward
                    tempReward = Reward(
                        ID: Int(rewardJSON["RewardID"].string!)!,
                        Description: rewardJSON["Description"].string!,
                        PointsRequired: Int(rewardJSON["PointsRequired"].string!)!)
                    print(tempReward)
                    self.Rewards.append(tempReward)
                }
            }
        
    }
    
    func updateIP() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let postEndpoint: String = "https://extremaheroes-extrema.rhcloud.com/?getAllRewardsForEvent=\(ID)"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: postEndpoint)!
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            do {
                if let json = String(data:data!, encoding: NSUTF8StringEncoding) {
                    let jsonData = JSON(json)
                    for (key, subJson) in jsonData {
                        print(subJson)
                    }
                }
            } catch {
                print("bad things happened")
            }
        }).resume()
    }
    
    private func getDemoRewards(){
        let reward1 = Reward(ID: 1, Description: "Sleutelhanger", PointsRequired: 1)
        let reward2 = Reward(ID: 2, Description: "Gratis Coca Cola bij entree", PointsRequired: 3)
        let reward3 = Reward(ID: 3, Description: "4 consumpties", PointsRequired: 5)
        let reward4 = Reward(ID: 4, Description: "10% korting", PointsRequired: 10)
        
        self.Rewards.append(reward1)
        self.Rewards.append(reward2)
        self.Rewards.append(reward3)
        self.Rewards.append(reward4)
    }
}

