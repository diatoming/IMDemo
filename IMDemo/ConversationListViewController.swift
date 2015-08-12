//
//  ConversationListViewController.swift
//  IMDemo
//
//  Created by Jeff Leung on 15/7/31.
//  Copyright (c) 2015年 Jeff Leung. All rights reserved.
//

import UIKit

class ConversationListViewController: RCConversationListViewController {
        
     let conVC = RCConversationViewController()
    
    @IBAction func ShowMenu(sender: UIBarButtonItem) {
  
        
        let items = [
        
            MenuItem(title: "客服", iconName: "service", glowColor: UIColor.redColor(), index: 0),
            MenuItem(title: "与CaptainSpock聊天", iconName: "conversation", glowColor: UIColor.blackColor(), index: 1),
            MenuItem(title: "通讯录", iconName: "contacts", glowColor: UIColor.yellowColor(), index: 2),
            MenuItem(title: "关于", iconName: "about", glowColor: UIColor.grayColor(), index: 3)
            
        ]
        
          let menu =    PopMenu(frame: self.view.bounds, items: items)
        
          menu.menuAnimationType = PopMenuAnimationType.NetEase
        
        if menu.isShowed{
            return
        }
        
        menu.didSelectedItemCompletion = { (SelectedItem:MenuItem!) -> Void in
            
           
            switch SelectedItem.index {
            case 1:
                        //代码跳转到会话节目
                        let conVC = RCConversationViewController()
                
                         conVC.targetId = "Spock"
                        conVC.userName = "CaptainSpock"
                        conVC.conversationType = RCConversationType.ConversationType_PRIVATE
                
                        conVC.title = conVC.userName
                
                        self.navigationController?.pushViewController(conVC, animated: true)
                        self.tabBarController?.tabBar.hidden = true
            default :
                print(SelectedItem.title)
                
            }
            
            
            
    }
    
      menu.showMenuAtView(self.view)
        
    }   
    
    func ClickMenu1(){
        
        print("与客服聊天")
    }
    
    func ClickMenu2(){
        
        print("与CaptainSpock聊天")
    }

    
    
    
     override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.connectServer({ () -> Void in
            
            self.setDisplayConversationTypes([
                
                RCConversationType.ConversationType_APPSERVICE.rawValue,
                RCConversationType.ConversationType_CHATROOM.rawValue,
                RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue,
                 RCConversationType.ConversationType_DISCUSSION.rawValue,
                RCConversationType.ConversationType_GROUP.rawValue,
                RCConversationType.ConversationType_PRIVATE.rawValue,
                RCConversationType.ConversationType_PUBLICSERVICE.rawValue,
                RCConversationType.ConversationType_SYSTEM.rawValue
                
                
                
                
                ])
            
               self.refreshConversationTableViewIfNeeded()
            
            
            
        })
        
        
        
        
        
        // Do any additional setup after loading the view.
        
        
        
        
        
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destCV = segue.destinationViewController as? RCConversationViewController
        
        destCV?.targetId =  self.conVC.targetId
        destCV?.userName = self.conVC.userName
        destCV?.conversationType = self.conVC.conversationType
        destCV?.title = conVC.title
               
        self.tabBarController?.tabBar.hidden = true
        
        
    }
    
     override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {

        
                 conVC.targetId = model.targetId
                conVC.userName = model.conversationTitle
                conVC.conversationType = RCConversationType.ConversationType_PRIVATE
        
                conVC.title = model.conversationTitle

           self.performSegueWithIdentifier("tapOnCell", sender: self)
        
        
    }

}
