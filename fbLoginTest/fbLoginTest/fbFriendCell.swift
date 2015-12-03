//
//  fbFriendCell.swift
//  fbLoginTest
//
//  Created by Fhict on 21/10/15.
//  Copyright © 2015 Robin. All rights reserved.
//

import UIKit

class fbFriendCell: UITableViewCell {
    @IBOutlet weak var fbProfile: UIImageView!
    @IBOutlet weak var fbName: UILabel!
    @IBOutlet weak var fbEvadeSwitch: UISwitch!
    
    var fbFriend:Friend = Friend(id: "-1", name: "-1")

    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("cell init")
        fbEvadeSwitch.setOn(false, animated: false)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func evadeClicked(sender: AnyObject)
    {
        if(!fbEvadeSwitch.on)
        {
            print("Turning evasion off")
            fbEvadeSwitch.setOn(false, animated: true)
            self.fbFriend.evaded = false;
            print(self.fbFriend.evaded)
        }
        else if(fbEvadeSwitch.on)
        {
            print("Turning evasion on")
            fbEvadeSwitch.setOn(true, animated: true)
            self.fbFriend.evaded = true;
            print(self.fbFriend.evaded)
        }
    }
    /*
    @IBAction func evadeClicked(sender: AnyObject) {
        if fbEvadeSwitch.on
        {
            print("Turning evasion off")
            fbEvadeSwitch.setOn(false, animated: true)
            self.fbFriend.evaded = false;
        }
        else
        {
            print("Turning evasion on")
            fbEvadeSwitch.setOn(true, animated: true)
            self.fbFriend.evaded = true;
        }

    }*/
    
    func setFriend(fbFriend:Friend)
    {
        self.fbFriend = fbFriend
    }

}
