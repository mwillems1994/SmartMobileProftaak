//
//  ViewController.swift
//  RewardDemo
//
//  Created by Marco Willems on 09/12/15.
//  Copyright © 2015 ExtremaHeroes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var event = Event(ID: 1, Name: "Outdoor", Active: "1")
        
        print(event.Rewards.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

