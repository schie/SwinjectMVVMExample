//
//  AppDelegate.swift
//  SwinjectMVVMExample
//
//  Created by Dustin Schie on 2/26/16.
//  Copyright © 2016 Dustin Schie. All rights reserved.
//

import UIKit
import Swinject
import ExampleModel
import ExampleViewModel
import ExampleView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let container = Container() { container in
        // models
        container.register(Networking.self) { _ in Network() }
        container.register(ImageSearching.self) { r in
            ImageSearch(network: r.resolve(Networking.self)!)
        }
        
        // view models
        container.register(ImageSearchTableViewModeling.self) { r in
            ImageSearchTableViewModel(
                imageSearch: r.resolve(ImageSearching.self)!,
                network: r.resolve(Networking.self)!)
        }
        
        // views
        container.registerForStoryboard(ImageSearchTableViewController.self) { r, c in
            c.viewModel = r.resolve(ImageSearchTableViewModeling.self)!
        }
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = UIColor.whiteColor()
        window.makeKeyAndVisible()
        self.window = window
        
        let bundle = NSBundle(forClass: ImageSearchTableViewController.self)
        let storboard = SwinjectStoryboard.create(
            name: "Main",
            bundle: bundle,
            container:  container
        )
        window.rootViewController = storboard.instantiateInitialViewController()
        
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
