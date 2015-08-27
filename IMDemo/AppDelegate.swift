//
//  AppDelegate.swift
//  IMDemo
//
//  Created by Jeff Leung on 15/7/27.
//  Copyright (c) 2015年 Jeff Leung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCIMUserInfoDataSource{

    var window: UIWindow?
    

    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        
        
        let userInfo = RCUserInfo()
        
        userInfo.userId = userId
        
        
        switch userId {
            
          case "Spock" :
            
            userInfo.name = "CaptainSpock"
            userInfo.portraitUri = "http://chuantu.biz/t2/11/1439401786x-1376440123.jpg"
            
        case "CaptainKirk" :
            
            userInfo.name = "Jim"
            userInfo.portraitUri = "http://chuantu.biz/t2/11/1439401700x-1376440123.png"
            
            
            
            
        default:
            print("无此用户")
            
        }
        
        return completion(userInfo)
        
    }
        
    
    func connectServer(completion:()->Void){

        //初始化appkey
        RCIM.sharedRCIM().initWithAppKey("pwe86ga5el346")
        
        
        
        //用Token测试连接
        RCIM.sharedRCIM().connectWithToken("dduW7igqiqgzwM72pYHtCPU61chM1C4dynSJnNAGXaDUQf1ZFZjAZDahviHgAbF6/7GIR/obbDqMSEjYI01+5Q==", success: { (_) -> Void in
            
            
            let currentUser = RCUserInfo(userId: "Spock", name: "CaptainSpock", portrait: "http://chuantu.biz/t2/11/1439401786x-1376440123.jpg")
            
            
            RCIM.sharedRCIM().currentUserInfo = currentUser
            
            print(" 连接成功!")
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
              completion()
            
            })
            
            
            }, error: { (code:RCConnectErrorCode) -> Void in
                print("无法连接! \(code)")
                
            }) { () -> Void in
                print("无效Token")
            }


        
    }
    
    
    
   
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        //设置用户信息提供者为自己 AppDelegate
                RCIM.sharedRCIM().userInfoDataSource = self
        

        
        //获得LeanCloud授权
        
        //如果使用美国站点，请加上这行代码 [AVOSCloud useAVCloudUS];


        AVOSCloud.setApplicationId("gDPi4CyGWPMGTVWcm1TrTjaG", clientKey: "4B3q1SBheDgNosqa3CfLucQd")
        
        
        return true
    }
    
                func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

