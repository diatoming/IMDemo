//
//  ConversationViewController.swift
//  IMDemo
//
//  Created by Jeff Leung on 15/7/28.
//  Copyright (c) 2015年 Jeff Leung. All rights reserved.
//

import UIKit

class ConversationViewController: RCConversationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        
        self.targetId = "Spock"
        
        self.userName = "CaptainSpock"
        

        self.conversationType = .ConversationType_PRIVATE
        
        
        self.title = userName 
        
        
        // Do any additional setup after loading the view.
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
