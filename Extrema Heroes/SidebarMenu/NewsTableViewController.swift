//
//  NewsTableViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!

    override func viewDidLoad() {
        let account = Account()
        if account.getId() == 0{
            //segue!
        }
        super.viewDidLoad()

        if revealViewController() != nil {
//            revealViewController().rearViewRevealWidth = 62
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"

            revealViewController().rightViewRevealWidth = 150
            extraButton.target = revealViewController()
            extraButton.action = "rightRevealToggle:"

            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 4
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsTableViewCell

        // Configure the cell...
        if indexPath.row == 0 {
            cell.postImageView.image = UIImage(named: "main_photo_profile")
            cell.postTitleLabel.text = ""
            cell.authorLabel.text = "1/2 until next reward"
            cell.authorImageView.image = UIImage(named: "")

        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "")
            cell.postTitleLabel.text = "Coca Cola or Redbull drink"
            cell.authorLabel.text = "1/2"
            cell.authorImageView.image = UIImage(named: "Coke")
            
        } else if indexPath.row == 2 {
    cell.postImageView.image = UIImage(named: "")
    cell.postTitleLabel.text = "Building a Chat App in Swift Using Multipeer Connectivity Framework"
    cell.authorLabel.text = "Gabriel Theodoropoulos"
    cell.authorImageView.image = UIImage(named: "appcoda-300")
    
    } else {
            cell.postImageView.image = UIImage(named: "")
            cell.postTitleLabel.text = "A Beginner’s Guide to Animated Custom Segues in iOS 8"
            cell.authorLabel.text = "Gabriel Theodoropoulos"
            cell.authorImageView.image = UIImage(named: "appcoda-300")
            
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
