//
//  AppDelegate.swift
//  MGSideMenuKit
//
//  Created by AldoOS on 03/11/2019.
//  Copyright (c) 2019 AldoOS. All rights reserved.
//

import UIKit
import MGSideMenuKit
import MGTemplateKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window:UIWindow?
    var sideMenu:MGSideMenu!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MGTemplate.setup()
        window = UIWindow(frame: UIScreen.main.bounds)
      
        sideMenu = MGSideMenu()
        sideMenu.dataSource = SideMenuDataSource(sideMenu: sideMenu)
        sideMenu.delegate = SideMenuDelegate()

        window?.rootViewController = sideMenu.containerController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}








class SideMenuDataSource: MGSideMenuDataSource {

    init(sideMenu: MGSideMenu) {
        print(sideMenu)
    }
    
    var data: MGSideMenuData {
        let data = MGSideMenuData()
        data.title = "Megageneral Inc."
        data.image = #imageLiteral(resourceName: "MGIconLight")
        return data
    }
    
    var items: [MGSideMenuItem] {
        var newData = [MGSideMenuItem]()
        
        let homeItem = MGSideMenuItem()
        homeItem.title = "Home"
        homeItem.icon = UIImage(icon: .ionicons(IoniconsType.androidHome), size: CGSize(width: 30, height: 30), textColor: .white, backgroundColor: .clear)
        homeItem.identifier = "menu.home.identifier"
        newData.append(homeItem)
        
        let videoItem = MGSideMenuItem()
        videoItem.title = "Video"
        videoItem.icon = UIImage(icon: .ionicons(IoniconsType.androidFilm), size: CGSize(width: 30, height: 30), textColor: .white)
        videoItem.identifier = "menu.video.identifier"
        newData.append(videoItem)
        
        let audioItem = MGSideMenuItem()
        audioItem.title = "Audio"
        audioItem.icon = UIImage(icon: .ionicons(IoniconsType.musicNote), size: CGSize(width: 30, height: 30), textColor: .white)
        audioItem.identifier = "menu.audio.identifier"
        newData.append(audioItem)
        
        return newData
    }
    
    var layout: MGSideMenuLayout {
        let layout = MGSideMenuLayout()
        layout.backgroundColor = MGTemplate.View.backgroundColor
        return layout
    }

    func primaryCenterController(fromController controller: MGMenuController) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "CenterController") as! CenterController
        vc.presenterController = controller
        return vc
    }
    
    func centerController(item: MGSideMenuItem, forIndexPath indexPath: IndexPath, fromController controller: MGMenuController) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "CenterController") as! CenterController
        vc.presenterController = controller

        switch indexPath.row {
        case 0:
            return vc
        case 1:
            return vc
        case 2:
            return vc
        default:
            return nil
        }
    }
}

class SideMenuDelegate: MGSideMenuDataDelegate {
    
    func menuController(_ controller: MGMenuController, didSelectItem item: MGSideMenuItem, atIndexPath indexPath: IndexPath) {

    }
    
    func menuController(_ controller: MGMenuController, canCloseMenuAtIndexPath indexPath: IndexPath) -> Bool {
        return true
//        return indexPath.row != 0 && indexPath.row != 1
    }
    
}
