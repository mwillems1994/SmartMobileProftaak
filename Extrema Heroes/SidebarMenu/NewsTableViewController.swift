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
        checkTempInvite()
        self.points = account.getPoints(1)
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"

            revealViewController().rightViewRevealWidth = 150
            extraButton.target = revealViewController()
            extraButton.action = "rightRevealToggle:"

            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            setRewards()
        }
    }
    
    func checkTempInvite() {
        let tempInvite = account.getTempInvite()
        let tempID = account.getId()
        if(tempInvite != 0){
            if(tempInvite != tempID){
                DatabaseManager.sharedInstance.insertInvite(tempInvite, AccountInvitedID: tempID)
            }
            account.removeTempInvite()
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
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
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
        return self.Rewards.count + 1
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        if indexPath.row == 0 {
            self.tableView.rowHeight = 220.0
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsTableViewCell
            //cell.postImageView.image = UIImage(named: "main_photo_profile")
            cell.postTitleLabel.text = account.getName()
            cell.authorImageView.image = account.getProfilePicture()
            if(self.Rewards.count > 0){
                cell.authorLabel.text = "\(self.points)/\(self.Rewards[0].PointsRequired) until next reward"
                cell.pvProgress.setProgress((1.0 / Float(self.Rewards[0].PointsRequired)) * Float(self.points), animated: true)
            }else{
                cell.authorLabel.text = ""
                cell.pvProgress.setProgress(1.0, animated: true)
            }
            return cell
        } else {
            self.tableView.rowHeight = 132.0
            let cell2 = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! RewardCell
            let index = -1 + indexPath.row
            setImage(cell2, index: index)
            setDescription(cell2, index: index)
            setPointsRequiredString(cell2, index: index)
            setProgressView(cell2, index: index)
            return cell2
        }
    }
    
    func setDescription(cell:RewardCell, index: Int) {
        let reward = self.Rewards[index] as Reward
        let description: String! = reward.Description
        
        if let lbDescription = cell.DescriptionLabel{
            lbDescription.text = description!
        }
    }
    
    func setPointsRequiredString(cell:RewardCell, index: Int) {
        let points = self.points
        let reward = self.Rewards[index] as Reward
        let pointRequiredString: String! = String(reward.PointsRequired)
        
        if let lbPoints = cell.PointsLabel{
            lbPoints.text = "\(points) / \(pointRequiredString) points"
        }
    }
    
    func setImage(cell:RewardCell, index: Int) {
        let points = self.points
        let reward = self.Rewards[index] as Reward
        var image: UIImage
        if(points >= reward.PointsRequired){
            image = UIImage(named: "\(reward.Code)_unlocked")!
        } else {
            image = UIImage(named: "\(reward.Code)_locked")!
        }
        
        if let img = cell.imIcon{
            img.image = image
        }
    }
    
    func setProgressView(cell:RewardCell, index: Int){
        let points = self.points
        let reward = self.Rewards[index] as Reward
        let progress = (1.0 / Float(reward.PointsRequired)) * Float(points)
        
        if let prgs = cell.pvProgress{
            prgs.setProgress(progress, animated: true)
        }
    }
}
