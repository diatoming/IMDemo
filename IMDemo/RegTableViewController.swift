//
//  RegTableViewController.swift
//  IMDemo
//
//  Created by Jeff Leung on 15/8/10.
//  Copyright © 2015年 Jeff Leung. All rights reserved.
//

import UIKit

class RegTableViewController: UITableViewController {

    
    @IBOutlet var loginTextFields: [UITextField]!
    
    
    @IBOutlet weak var user: UITextBox!
    
    @IBOutlet weak var password: UITextBox!
    
    @IBOutlet weak var mail: UITextBox!
    
    @IBOutlet weak var region: UITextBox!
    
    @IBOutlet weak var question: UITextBox!
    

    
    @IBOutlet weak var answer: UITextField!
    
    
    var possibleInputs : Inputs = []
    

    var doneButton : UIBarButtonItem?

    
    //必填项校验
    func checkRequireField(){
        

      //必填项空判断
        for textField in loginTextFields{
            
            if textField.text!.isEmpty{
                self.errorNotice("必填项不能为空")
            }
        }
        //邮箱合法性校验
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        guard predicate.evaluateWithObject(mail.text) else{
            self.errorNotice("邮箱格式错误")
            return
            
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBarHidden = false
        self.title = "新用户注册"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneButtonTap")
         self.navigationItem.rightBarButtonItem?.enabled = false
        
         doneButton = self.navigationItem.rightBarButtonItem
        
        let v1 = AJWValidator(type: .String)
        v1.addValidationToEnsureMinimumLength(3, invalidMessage: "用户名至少3位")
        v1.addValidationToEnsureMaximumLength(15, invalidMessage: "用户名最长15位")
        self.user.ajw_attachValidator(v1)
        
        v1.validatorStateChangedHandler = { (newState: AJWValidatorState) -> Void in
            switch newState {
                
            case .ValidationStateValid:
                
                 self.user.highlightState = UITextBoxHighlightState.Default
                
                self.possibleInputs.unionInPlace(Inputs.user)
                
            default:
                let errorMsg = v1.errorMessages.first as? String
                self.user.highlightState = UITextBoxHighlightState.Wrong(errorMsg!)
                
                self.possibleInputs.subtractInPlace(Inputs.user)
                
            }
            
            self.doneButton?.enabled = self.possibleInputs.isAllOK()
        }
        
         let v2 = AJWValidator(type: .String)
         v2.addValidationToEnsureMinimumLength(3, invalidMessage: "密码至少3位")
         v2.addValidationToEnsureMaximumLength(15, invalidMessage: "密码最长15位")
         self.password.ajw_attachValidator(v2)
        
        v2.validatorStateChangedHandler = { (newState: AJWValidatorState) -> Void in
            
            switch newState {
                
            case .ValidationStateValid:
                
                self.password.highlightState = UITextBoxHighlightState.Default
                
                self.possibleInputs.unionInPlace(Inputs.password)
                
            default:
                let errorMsg = v2.errorMessages.first as? String
                self.password.highlightState = UITextBoxHighlightState.Wrong(errorMsg!)
                
                self.possibleInputs.subtractInPlace(Inputs.password)
                
            }
            
            self.doneButton?.enabled = self.possibleInputs.isAllOK()

            
        }
        
        let v3 = AJWValidator(type: .String)
        v3.addValidationToEnsureValidEmailWithInvalidMessage("Email格式不对")
        self.mail.ajw_attachValidator(v3)
        v3.validatorStateChangedHandler = { (newState: AJWValidatorState) -> Void in
            
            switch newState {
                
            case .ValidationStateValid:
                
                self.mail.highlightState = UITextBoxHighlightState.Default
                
                self.possibleInputs.unionInPlace(Inputs.mail)
                
            default:
                let errorMsg = v3.errorMessages.first as? String
                self.mail.highlightState = UITextBoxHighlightState.Wrong(errorMsg!)
                
                self.possibleInputs.subtractInPlace(Inputs.mail)
                
            }
            
            self.doneButton?.enabled = self.possibleInputs.isAllOK()
            

        
        
        
        }

    }
    
    //注册新用户
    
    
    
     func doneButtonTap(){
    //显示一个载入提示
    
        self.pleaseWait()
        
    //建立用户的 AVObject
        let user = AVObject(className: "IMUser")
    //把输入的文本框的值保存到对象中
        
        user["user"] = self.user.text
        user["password"] = self.password.text
        user["mail"] = self.mail.text
        user["region"] = self.region.text
        user["question"] = self .question.text
        user["answer"] = self.answer.text


  //查询用户名是否已经被注册
        let query = AVQuery(className: "IMUser")
        query.whereKey("user", equalTo: self.user.text)
        
    //执行查询
        query.getFirstObjectInBackgroundWithBlock { (object, e) -> Void in
            self.clearAllNotice()

            //如果查询到相关用户
            if object != nil {
             self.errorNotice("用户名已被注册")
             self.user.becomeFirstResponder()
             self.doneButton?.enabled = false

            } else {
                
            //用户注册
                user.saveInBackgroundWithBlock ({ (succeed, error) -> Void in
                    if succeed{
                        
                        self.successNotice("注册成功")
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    } else {
                       print(error)
                       
                        
                    }
                })

            
            }
        }

    }
        
    
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
