//
//  FriendsTableTableViewController.swift
//  fbLoginTest
//
//  Created by Fhict on 15/10/15.
//  Copyright © 2015 Robin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
//#import <Frameworks/FBSDKShareKit.h>
import FBSDKLoginKit
import Foundation


class FriendsTableTableViewController: UITableViewController
{
    var friendNames = [String]()
    
    var fbFriends = [Friend]()
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        let request = FBSDKGraphRequest(graphPath:"me/friends", parameters: ["fields":"id,name"]);
        
        request.startWithCompletionHandler
        { (connection, result, error) -> Void in
            if error == nil
            {
                print("Friends are : \(result)")
                
                let resultDict = result as! NSDictionary
                let data : NSArray = resultDict.objectForKey("data") as! NSArray
                
                for i in 0...data.count-1
                {
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    self.fbFriends.append(
                        Friend(id: valueDict.objectForKey("id") as! String,
                                name: valueDict.objectForKey("name") as! String))
                    
                    print("Current friend: \(self.fbFriends[i].name)")
                    
                    //self.friendNames.append(valueDict.objectForKey("name") as! String)
                    //print("vriend opgehaald: \(self.friendNames[i])")
                    //print(valueDict.objectForKey("name") as! String)
                }
                //print("reloading table")
                self.tableView.reloadData()
            }
            else
            {
                print("Error Getting Friends \(error)");
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("Rows: \(self.fbFriends.count)")
        return self.fbFriends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! fbFriendCell
    
        let currentName = indexPath.row
        cell.fbProfile.image = self.fbFriends[currentName].profilePicture
        cell.fbName.text = "\(currentName). \(self.fbFriends[currentName].name)"
        cell.setFriend(self.fbFriends[currentName])
    
    //print("Cell with friend: \(self.friendNames[currentName])")
        return cell
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell..
        let currentName = indexPath.row
        cell.imageView?.image = self.fbFriends[currentName].profilePicture
        cell.textLabel?.text = "\(currentName). \(self.fbFriends[currentName].name)";
        cell.
        
        //print("Cell with friend: \(self.friendNames[currentName])")
        return cell
    }*/
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


