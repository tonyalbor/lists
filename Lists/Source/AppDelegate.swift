//
//  AppDelegate.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import CoreLocation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Network
        let network = Network.default
        
        // Search
        let searchService = YelpRestaurantSearchService(network: network)
        let locationManager = CoreLocationManager(manager: CLLocationManager())
        let context = RestaurantSearchContext(service: searchService, locationManager: locationManager)
        let viewController = RestaurantSearchViewController(context: context)
        let searchNavigation = UINavigationController(rootViewController: viewController)
        searchNavigation.navigationBar.prefersLargeTitles = true
        
        // Lists
        let listsService = ListsServiceImp(network: network)
        let listContext = ListsContext(service: listsService)
        let lists = ListsViewController(context: listContext)
        let listsNavigation = UINavigationController(rootViewController: lists)
        listsNavigation.navigationBar.prefersLargeTitles = true
        
        // Tab bar
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [searchNavigation, listsNavigation]
        searchNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        listsNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

