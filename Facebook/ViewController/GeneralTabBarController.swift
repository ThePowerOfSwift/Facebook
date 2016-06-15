//
//  GeneralTabBarController.swift
//  Facebook
//
//  Created by Mihail Șalari on 6/14/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class GeneralTabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.translucent = false
        tabBar.clipsToBounds = true
        
        let topBorder = CALayer()
        topBorder.frame = CGRectMake(0, 0, 1000, 0.5)
        topBorder.backgroundColor = UIColor.rgb(229, green: 231, blue: 235, alpha: 1).CGColor
        tabBar.layer.addSublayer(topBorder)
        
        
        
        let layout = UICollectionViewFlowLayout()
        let facebookFeedController = FeedViewController(collectionViewLayout: layout)
        
        let navigationController = UINavigationController(rootViewController: facebookFeedController)
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named: "news_feed_icon")
        
        
        let requestNavigationController = RequestsViewController()
        let secondNavController = UINavigationController(rootViewController: requestNavigationController)
        secondNavController.title = "Requests"
        secondNavController.tabBarItem.image = UIImage(named: "requests_icon")
        
        let messegerViewController = UIViewController()
        messegerViewController.navigationItem.title = "Messenger"
        
        let messengerNavigationController = UINavigationController(rootViewController: messegerViewController)
        messengerNavigationController.title = "Messenger"
        messengerNavigationController.tabBarItem.image = UIImage(named: "messenger_icon")
        messengerNavigationController.view.backgroundColor = UIColor.whiteColor()
        
        let notificationsViewController = UIViewController()
        notificationsViewController.title = "Notifications"
        
        let notificationsNavigationController = UINavigationController(rootViewController: notificationsViewController)
        notificationsNavigationController.title = "Notifications"
        notificationsNavigationController.tabBarItem.image = UIImage(named: "globe_icon")
        notificationsNavigationController.view.backgroundColor = UIColor.whiteColor()
        
        
        let moreViewController = UIViewController()
        moreViewController.title = "More"
        
        let moreNavigationController = UINavigationController(rootViewController: moreViewController)
        moreNavigationController.title = "More"
        moreNavigationController.tabBarItem.image = UIImage(named: "more_icon")
        moreNavigationController.view.backgroundColor = UIColor.whiteColor()
        
        
        viewControllers = [navigationController, secondNavController, messengerNavigationController, notificationsNavigationController, moreNavigationController]
    }
}
