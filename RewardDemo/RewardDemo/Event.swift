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
        getDemoRewards()
    }
    
    private func getRewards() {
        RestApiManager.sharedInstance.getRewardsForEvent(1) {json in
            for (index, subJson): (String, JSON) in json {
                let rewardJSON:JSON = JSON(subJson.object)
                let tempReward:Reward
                tempReward = Reward(
                    ID: Int(rewardJSON["RewardID"].string!)!,
                    Description: rewardJSON["Description"].string!,
                    PointsRequired: Int(rewardJSON["PointsRequired"].string!)!)
                print(tempReward)
                self.Rewards.insert(tempReward, atIndex: (self.Rewards.count))
            }
        }
    }
    
    private func getDemoRewards(){
        var reward1 = Reward(ID: 1, Description: "Sleutelhanger", PointsRequired: 1)
        var reward2 = Reward(ID: 2, Description: "Gratis Coca Cola bij entree", PointsRequired: 3)
        var reward3 = Reward(ID: 3, Description: "4 consumpties", PointsRequired: 5)
        var reward4 = Reward(ID: 4, Description: "10% korting", PointsRequired: 10)
        
        self.Rewards.append(reward1)
        self.Rewards.append(reward2)
        self.Rewards.append(reward3)
        self.Rewards.append(reward4)
    }
}

