//
//  ViewController.swift
//  Notifications
//
//  Created by Fhict on 16/10/15.
//  Copyright © 2015 Fhict. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationmanager:Notificationmanager = Notificationmanager()
        notificationmanager.create()
        notificationmanager.schedule("hallooo")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

