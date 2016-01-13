//
//  RefferalViewController.swift
//  Extrema Heroes
//
//  Created by Kevin Borghmans on 11/12/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit

class RefferalViewController: UIViewController {
    @IBOutlet weak var imgQRCode: UIImageView!

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        imgQRCode.image = generateQRCode("Marco Willems")

        // Do any additional setup after loading the view.
    }
        
    func generateQRCode(data: String) -> UIImage{
        let inputMessage = data.dataUsingEncoding(NSISOLatin1StringEncoding)!
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter!.setValue(inputMessage, forKey: "inputMessage")
        filter!.setValue("Q", forKey: "inputCorrectionLevel")
        
        let image = filter!.outputImage!
        
        let scaleX = imgQRCode.frame.size.width / image.extent.size.width
        let scaleY = imgQRCode.frame.size.height / image.extent.size.height
        
        let transformedImage = image.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        return UIImage(CIImage: transformedImage)
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