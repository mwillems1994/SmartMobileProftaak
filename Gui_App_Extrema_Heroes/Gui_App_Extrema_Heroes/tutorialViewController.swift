//
//  tutorialViewController.swift
//  Gui_App_Extrema_Heroes
//
//  Created by Kevin Borghmans on 04/12/15.
//  Copyright © 2015 Kevin Borghmans. All rights reserved.
//

import UIKit

class tutorialViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!
    
    @IBAction func SkipTut(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageTitles = NSArray(objects: "", "", "")
        
        self.pageImages = NSArray(objects: "promote_1", "promote_2","promote_3")
        
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        
        let startVC = self.viewControllerAtIndex(0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        

        // Do any additional setup after loading the view.
    }
    
    
    
    func viewControllerAtIndex(index: Int) -> ContentViewController
        
    {
        
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            
            return ContentViewController()
            
        }
        
        
        
        let vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        
        
        
        vc.imageFile = self.pageImages[index] as! String
        
        vc.titleText = self.pageTitles[index]as! String
        
        vc.pageIndex = index
        
        
        
        return vc
        
        
        
        
        
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
        
    {
        
        
        
        let vc = viewController as! ContentViewController
        
        var index = vc.pageIndex as Int
        
        
        
        
        
        if (index == 0 || index == NSNotFound)
            
        {
            
            return nil
            
            
            
        }
        
        
        
        index--
        
        return self.viewControllerAtIndex(index)
        
        
        
    }
    
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        
        
        let vc = viewController as! ContentViewController
        
        var index = vc.pageIndex as Int
        
        
        
        if (index == NSNotFound)
            
        {
            
            return nil
            
        }
        
        
        
        index++
        
        
        
        if (index == self.pageTitles.count)
            
        {
            
            return nil
            
        }
        
        
        
        return self.viewControllerAtIndex(index)
        
        
        
    }
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
        
    {
        
        return self.pageTitles.count
        
    }
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
        
    {
        
        return 0
        
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
