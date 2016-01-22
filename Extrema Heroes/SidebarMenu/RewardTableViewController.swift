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
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
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
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Rewards.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return basicCellAtIndexPath(indexPath)
    }
    
    func basicCellAtIndexPath(indexPath:NSIndexPath) -> RewardCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(basicCellIdentifier) as! RewardCell
        if(self.Rewards.count > 0 && indexPath.row < self.Rewards.count){
            setImage(cell, indexPath: indexPath)
            setDescription(cell, indexPath: indexPath)
            setPointsRequiredString(cell, indexPath: indexPath)
            setProgressView(cell, indexPath: indexPath)
        }
        return cell
    }
    
    func setDescription(cell:RewardCell, indexPath:NSIndexPath) {
        print("description begin")
        let reward = self.Rewards[indexPath.row] as Reward
        let description: String! = reward.Description
        
        if let lbDescription = cell.DescriptionLabel{
            lbDescription.text = description!
        }
        print("description end")
    }
    
    func setPointsRequiredString(cell:RewardCell, indexPath:NSIndexPath) {
        print("points begin")
        let points = self.points
        let reward = self.Rewards[indexPath.row] as Reward
        let pointRequiredString: String! = String(reward.PointsRequired)
        
        if let lbPoints = cell.PointsLabel{
            lbPoints.text = "\(points) / \(pointRequiredString) points"
        }
        print("points end")
    }
    
    func setImage(cell:RewardCell, indexPath:NSIndexPath) {
        print("image begin")
        let points = self.points
        let reward = self.Rewards[indexPath.row] as Reward
        var image: UIImage
        
        if let img = cell.imIcon{
            if(points >= reward.PointsRequired){
                image = UIImage(named: "\(reward.Code)_unlocked")!
            } else {
                image = UIImage(named: "\(reward.Code)_locked")!
            }
            img.image = image
        }
        print("image end")
    }
    
    func setProgressView(cell:RewardCell, indexPath: NSIndexPath){
        print("progress begin")
        let points = self.points
        let reward = self.Rewards[indexPath.row] as Reward
        var progress = (1.0 / Float(reward.PointsRequired)) * Float(points)
        if (progress > 1.0){
            progress = 1.0
        }
        
        if let prgs = cell.pvProgress{00
            prgs.setProgress(progress, animated: true)
        }
        print("progress end")
    }
}

