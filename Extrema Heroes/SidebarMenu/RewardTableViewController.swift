//
//  RewardTableViewController.swift
//  Extrema Heroes
//
//  Created by Marco Willems on 08/01/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class RewardTableViewController: UITableViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    let account = Account()
    var Rewards = [Reward]()
    let basicCellIdentifier = "RewardCell"
    var points = 0
    private func setRewards(){
        DatabaseManager.sharedInstance.getRewardsForEvent(1) { json in
            var tempReward : Reward
            for (_, subJson): (String, JSON) in json {
                let rewardJson:JSON = JSON(subJson.object)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        points = account.getPoints(1)
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        setRewards()
        sleep(1)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Rewards.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return basicCellAtIndexPath(indexPath)
    }
    
    func basicCellAtIndexPath(indexPath:NSIndexPath) -> RewardCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(basicCellIdentifier) as! RewardCell
        setImage(cell, indexPath: indexPath)
        setDescription(cell, indexPath: indexPath)
        setPointsRequiredString(cell, indexPath: indexPath)
        setProgressView(cell, indexPath: indexPath)
        return cell
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
        var progress = (1.0 / Float(reward.PointsRequired)) * Float(points)
        cell.pvProgress.setProgress(progress, animated: true)
    }
}

