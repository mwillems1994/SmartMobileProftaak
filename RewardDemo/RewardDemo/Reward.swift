//
//  Reward.swift
//  RewardDemo
//
//  Created by Marco Willems on 09/12/15.
//  Copyright © 2015 ExtremaHeroes. All rights reserved.
//

import Foundation
public class Reward : CustomStringConvertible{
    public var description: String { return "ID: \(ID), Description: \(Description), PointsRequired: \(PointsRequired)" }
    var ID : Int!
    var Description : String!
    var PointsRequired : Int!
    
    init(ID : Int, Description : String, PointsRequired : Int){
        self.ID = ID
        self.Description = Description
        self.PointsRequired = PointsRequired
    }
}
