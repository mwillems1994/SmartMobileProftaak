//
//  Reward.swift
//  Extrema Heroes
//
//  Created by Marco Willems on 08/01/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation
public class Reward : CustomStringConvertible{
    public var description: String { return "ID: \(ID), Description: \(Description), PointsRequired: \(PointsRequired)" }
    var ID : Int!
    var PointsRequired : Int!
    var Description : String!
    
    init(ID : Int, PointsRequired : Int, Description : String){
        self.ID = ID
        self.PointsRequired = PointsRequired
        self.Description = Description
    }
}