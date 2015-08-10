//
//  LoginViewController.swift
//  IMDemo
//
//  Created by Jeff Leung on 15/8/8.
//  Copyright © 2015年 Jeff Leung. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController,JSAnimatedImagesViewDataSource {

    @IBOutlet weak var loginStackView: UIStackView!
    
    
    @IBOutlet weak var WallpaperImageView: JSAnimatedImagesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.WallpaperImageView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true

    }
    
    
    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
        return 3
    }
    
    
    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named: "image\(index + 1)")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
        UIView.animateWithDuration(1) { () -> Void in
            self.loginStackView.axis = UILayoutConstraintAxis.Vertical

            }
        
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
