//
//  AppDelegate.swift
//  GoodBook
//
//  Created by zhy on 17/3/23.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
//        //设置appKey
        UMSocialManager.default().umSocialAppkey = "5861e5daf5ade41326001eab"
        self.configUSharePlatforms()
        

        UINavigationBar.appearance().tintColor = UIColor.gray
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -65), for:.default)
        
        let manager = IQKeyboardManager.shared()
        manager.isEnabled = true
        manager.shouldResignOnTouchOutside = true
        manager.shouldToolbarUsesTextFieldTintColor = false
        manager.isEnableAutoToolbar = false

        AVOSCloud.setApplicationId("Hnxntsao7goM3z2y9S4O0XGl-gzGzoHsz", clientKey: "WQSvl4lUAgIGeo7ntFzHGSex")
        
        let tabbarController = UITabBarController()
        
        let rank   = UINavigationController(rootViewController: rankViewController())
        let search = UINavigationController(rootViewController: searchViewController())
        let push   = UINavigationController(rootViewController: pushViewController())
        let circle = UINavigationController(rootViewController: circleViewController())
        let more   = UINavigationController(rootViewController: moreViewController())
        
        tabbarController.viewControllers = [rank,search,push,circle,more]
        
        let tabbarItem1 = UITabBarItem(title: "排行榜", image: UIImage(named:"bio"), selectedImage: UIImage(named: "bio_red"))
        let tabbarItem2 = UITabBarItem(title: "发现", image: UIImage(named:"timer 2"), selectedImage: UIImage(named: "timer 2_red"))
        let tabbarItem3 = UITabBarItem(title: "", image: UIImage(named:"pencil"), selectedImage: UIImage(named: "pencil_red"))
        let tabbarItem4 = UITabBarItem(title: "圈子", image: UIImage(named:"users two-2"), selectedImage: UIImage(named: "users two-2_red"))
        let tabbarItem5 = UITabBarItem(title: "更多", image: UIImage(named:"more"), selectedImage: UIImage(named: "more_ren"))
        rank.tabBarItem   = tabbarItem1
        search.tabBarItem = tabbarItem2
        push.tabBarItem   = tabbarItem3
        circle.tabBarItem = tabbarItem4
        more.tabBarItem   = tabbarItem5
        
        rank.tabBarController?.tabBar.tintColor = MAIN_RED
        
        self.window?.rootViewController = tabbarController
        
        self.window?.makeKeyAndVisible()
        
        
        return true
    }
    
    
    func configUSharePlatforms()
    {
    /* 设置微信的appKey和appSecret */
    UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: "wxdc1e388c3822c80b", appSecret: "3baf1193c85774b3fd9d18447d76cab0", redirectURL: "http://mobile.umeng.com/social")
        
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: "1105821097", appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
    
    /* 设置新浪的appKey和appSecret */
    UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: "3921700954", appSecret: "04b48b094faeb16683c32669824ebdad", redirectURL: "http://mobile.umeng.com/social")

    }

}

