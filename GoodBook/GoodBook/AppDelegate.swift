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

}

