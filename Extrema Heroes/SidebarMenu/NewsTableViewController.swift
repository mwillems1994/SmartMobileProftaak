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

    let account = Account()
    var Rewards = [Reward]()
    let basicCellIdentifier = "RewardCell"
    var points = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.points = account.getPoints(1)
        if revealViewController() != nil {
//            revealViewController().rearViewRevealWidth = 62
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"

            revealViewController().rightViewRevealWidth = 150
            extraButton.target = revealViewController()
            extraButton.action = "rightRevealToggle:"

            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            setRewards()
            sleep(1)
        }
    }
    
    private func setRewards(){
        DatabaseManager.sharedInstance.getRewardsForEvent(1) { json in
            var tempReward : Reward
            for (_, subJson): (String, JSON) in json {
                let rewardJson:JSON = JSON(subJson.object)
                let pointsRequired = Int(rewardJson["PointsRequired"].string!)!
                if(self.points < pointsRequired){
                    tempReward = Reward(
                        ID: Int(rewardJson["RewardID"].string!)!,
                        PointsRequired: Int(rewardJson["PointsRequired"].string!)!,
                        Description: rewardJson["Description"].string!,
                        Code: rewardJson["RewardCode"].string!
                    )
                self.Rewards.append(tempReward)
                }
            }
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
        return self.Rewards.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


        // Configure the cell...
        if indexPath.row == 0 {
            self.tableView.rowHeight = 218.0
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsTableViewCell
            //cell.postImageView.image = UIImage(named: "main_photo_profile")
            cell.postTitleLabel.text = account.getName()
            cell.authorLabel.text = "1/2 until next reward"
            cell.authorImageView.image = account.getProfilePicture()
            return cell
        } else {
            self.tableView.rowHeight = 132.0
            let cell2 = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! RewardCell
            setImage(cell2, indexPath: indexPath)
            setDescription(cell2, indexPath: indexPath)
            setPointsRequiredString(cell2, indexPath: indexPath)
            setProgressView(cell2, indexPath: indexPath)
            return cell2
        }
        
        let cell2 = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! RewardCell
        setImage(cell2, indexPath: indexPath)
        setDescription(cell2, indexPath: indexPath)
        setPointsRequiredString(cell2, indexPath: indexPath)
        setProgressView(cell2, indexPath: indexPath)
        return cell2
    }
    func setDescription(cell:RewardCell, indexPath:NSIndexPath) {
        let reward = self.Rewards[indexPath.row] as Reward
        let description: String! = reward.Description
        cell.DescriptionLabel.text = description!
    }
    
    func setPointsRequiredString(cell:RewardCell, indexPath:NSIndexPath) {
        let points = self.points
        let reward = self.Rewards[indexPath.row] as Reward
        let pointRequiredString: String! = String(reward.PointsRequired)
        cell.PointsLabel.text = "\(points) / \(pointRequiredString) points"
    }
    
    func setImage(cell:RewardCell, indexPath:NSIndexPath) {
        let points = self.points
        let reward = self.Rewards[indexPath.row] as Reward
        var image: UIImage
        if(points >= reward.PointsRequired){
            image = UIImage(named: "\(reward.Code)_unlocked")!
        } else {
            image = UIImage(named: "\(reward.Code)_locked")!
        }
        
        cell.imIcon.image = image
    }
    
    func setProgressView(cell:RewardCell, indexPath: NSIndexPath){
        let points = self.points
        let reward = self.Rewards[indexPath.row] as Reward
        var progress = (100.0 / Float(reward.PointsRequired)) * Float(points)
        if(progress >= 100.0){
            progress = 100.0
        }
        cell.pvProgress.setProgress(progress, animated: false)
    }

}
