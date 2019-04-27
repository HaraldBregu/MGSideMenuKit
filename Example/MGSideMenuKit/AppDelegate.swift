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
    var sideMenuController:MGSideMenuController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MGTemplate.setup()
        window = UIWindow(frame: UIScreen.main.bounds)
      
        sideMenuController = MGSideMenuController().instance
        sideMenuController.assets = Asset.instance
        sideMenuController.dataSource = self
        sideMenuController.delegate = self
        
        window?.rootViewController = sideMenuController
        window?.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate: MGSideMenuControllerDataSource, MGSideMenuControllerDelegate {
    
    func controller(_ parentController: UIViewController) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "CenterController") as! CenterController
        vc.controller = sideMenuController
        return vc
    }
    
    func controller(_ parentController: UIViewController, forIndexPath indexPath: IndexPath, withItem item: AnyObject) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        switch indexPath.row {
        case 0:
            let vc = storyboard.instantiateViewController(withIdentifier: "vc1")
            //vc.controller = sideMenuController
            return vc
        case 1:
            let vc = storyboard.instantiateViewController(withIdentifier: "vc2")
            //vc.controller = sideMenuController
            return vc
        case 2:
            let vc = storyboard.instantiateViewController(withIdentifier: "CenterController") as! CenterController
            vc.controller = sideMenuController
            return vc
        default:
            return nil
        }
    }
    
    func controller(_ controller: UIViewController, didSelectItem item: AnyObject, atIndexPath indexPath: IndexPath) {
        
    }
    
    func controller(_ controller: UIViewController, canSelectItem item: AnyObject, atIndexPath indexPath: IndexPath) -> Bool {
        return indexPath.row > 0
    }

}


class Asset {}
extension Asset: SideMenuAssetsObject {}

protocol SideMenuAssetsObject {
    static var instance:SideMenuAssets { get }
}

extension SideMenuAssetsObject {
    static var instance:SideMenuAssets {
        
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

        return SideMenuAssets(
            string: SideMenuString(
                title: "Megageneral Inc."),
            font: SideMenuFont(
                title: nil),
            image: SideMenuImage(
                avatar: #imageLiteral(resourceName: "MGIconLight")),
            color: SideMenuColor(
                backgroundView: .blue,
                headerView: .blue,
                cellView: .black,
                cellLabel: .white),
            data: SideMenuData(
                items: newData,
                statusBarStyle: .default))
    }
}

struct SideMenuAssets:MGSideMenuAsset {
    var string: MGSideMenuString
    var font: MGSideMenuFont
    var image: MGSideMenuImage
    var color: MGSideMenuColor
    var data: MGSideMenuData
}

struct SideMenuString:MGSideMenuString {
    var title: String
}

struct SideMenuFont:MGSideMenuFont {
    var title: UIFont?
}

struct SideMenuImage:MGSideMenuImage {
    var avatar: UIImage?
}

struct SideMenuColor:MGSideMenuColor {
    var backgroundView: UIColor
    var headerView: UIColor
    var cellView: UIColor
    var cellLabel: UIColor
}

struct SideMenuData:MGSideMenuData {
    var items: [MGSideMenuItem]
    var statusBarStyle: UIStatusBarStyle
}
