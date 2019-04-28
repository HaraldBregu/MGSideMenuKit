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
        MGTemplate.setup(assets: Template.default)
    
        window = UIWindow(frame: UIScreen.main.bounds)
      
        sideMenuController = MGSideMenuController().instance
        sideMenuController.assets = AssetsData.setup
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
        vc.view.backgroundColor = MGTemplate.assets.color.view
        return vc
    }
    
    func controller(_ parentController: UIViewController, forIndexPath indexPath: IndexPath, withItem item: AnyObject) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        switch indexPath.row {
        case 0:
            let vc = storyboard.instantiateViewController(withIdentifier: "vc1")
            //vc.controller = sideMenuController
            vc.view.backgroundColor = MGTemplate.assets.color.view
            return vc
        case 1:
            let vc = storyboard.instantiateViewController(withIdentifier: "vc2")
            //vc.controller = sideMenuController
            vc.view.backgroundColor = MGTemplate.assets.color.view
            return vc
        case 2:
            let vc = storyboard.instantiateViewController(withIdentifier: "CenterController") as! CenterController
            vc.controller = sideMenuController
            vc.view.backgroundColor = MGTemplate.assets.color.view
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

class AssetsData {}

extension AssetsData: SideMenuAssetData {}

protocol SideMenuAssetData {
    static var setup:SideMenuAssets { get }
}

extension SideMenuAssetData {
    
    static var setup: SideMenuAssets {
        
        var newData = [MGSideMenuItem]()
        
        let homeItem = MGSideMenuItem()
        homeItem.title = "Dashboard"
        homeItem.icon = #imageLiteral(resourceName: "landing-page")
        homeItem.identifier = "menu.home.identifier"
        newData.append(homeItem)
        
        let theNextWeb = MGSideMenuItem()
        theNextWeb.title = "The Next Web"
        theNextWeb.icon = #imageLiteral(resourceName: "tnw")
        theNextWeb.identifier = "menu.theNextWeb.identifier"
        newData.append(theNextWeb)
        
        let techCrunch = MGSideMenuItem()
        techCrunch.title = "Tech Crunch"
        techCrunch.icon = #imageLiteral(resourceName: "techcrunch")
        techCrunch.identifier = "menu.techCrunch.identifier"
        newData.append(techCrunch)
        
        let theVerge = MGSideMenuItem()
        theVerge.title = "The Verge"
        theVerge.icon = #imageLiteral(resourceName: "thv")
        theVerge.identifier = "menu.theVerge.identifier"
        newData.append(theVerge)
        
        let digitalTrend = MGSideMenuItem()
        digitalTrend.title = "Digital Trend"
        digitalTrend.icon = #imageLiteral(resourceName: "digitaltrend")
        digitalTrend.identifier = "menu.digitalTrend.identifier"
        newData.append(digitalTrend)
        
        let webBrowser = MGSideMenuItem()
        webBrowser.title = "Website Project"
        webBrowser.icon = #imageLiteral(resourceName: "browser")
        webBrowser.identifier = "menu.webBrowser.identifier"
        newData.append(webBrowser)
        
        let maps = MGSideMenuItem()
        maps.title = "My Location"
        maps.icon = #imageLiteral(resourceName: "map")
        maps.identifier = "menu.maps.identifier"
        newData.append(maps)
        
        let videoItem = MGSideMenuItem()
        videoItem.title = "Video Player"
        videoItem.icon = #imageLiteral(resourceName: "youtube-1")
        videoItem.identifier = "menu.video.identifier"
        newData.append(videoItem)
        
        let audioItem = MGSideMenuItem()
        audioItem.title = "Audio Player"
        audioItem.icon = #imageLiteral(resourceName: "music-player (1)")
        audioItem.identifier = "menu.audio.identifier"
        newData.append(audioItem)
        
        let shopify = MGSideMenuItem()
        shopify.title = "My Store"
        shopify.icon = #imageLiteral(resourceName: "shopify")
        shopify.identifier = "menu.shopify.identifier"
        newData.append(shopify)
        
        let youtube = MGSideMenuItem()
        youtube.title = "Youtube"
        youtube.icon = #imageLiteral(resourceName: "youtube")
        youtube.identifier = "menu.youtube.identifier"
        newData.append(youtube)
        
        let facebook = MGSideMenuItem()
        facebook.title = "Facebook Page"
        facebook.icon = #imageLiteral(resourceName: "facebook")
        facebook.identifier = "menu.facebook.identifier"
        newData.append(facebook)
        
        let instagram = MGSideMenuItem()
        instagram.title = "Instagram Profile"
        instagram.icon = #imageLiteral(resourceName: "instagram")
        instagram.identifier = "menu.instagram.identifier"
        newData.append(instagram)
        
        let soundCloud = MGSideMenuItem()
        soundCloud.title = "Soundcloud"
        soundCloud.icon = #imageLiteral(resourceName: "soundcloud")
        soundCloud.identifier = "menu.soundCloud.identifier"
        newData.append(soundCloud)
        
        let tumblr = MGSideMenuItem()
        tumblr.title = "Tumblr"
        tumblr.icon = #imageLiteral(resourceName: "tumblr")
        tumblr.identifier = "menu.tumblr.identifier"
        newData.append(tumblr)
        
        let flick = MGSideMenuItem()
        flick.title = "Flickr"
        flick.icon = #imageLiteral(resourceName: "flickr")
        flick.identifier = "menu.flick.identifier"
        newData.append(flick)
        
        let twitter = MGSideMenuItem()
        twitter.title = "Twitter".localized
        twitter.icon = #imageLiteral(resourceName: "twitter")
        twitter.identifier = "menu.twitter.identifier"
        newData.append(twitter)
        
        let pinterest = MGSideMenuItem()
        pinterest.title = "Pinterest"
        pinterest.icon = #imageLiteral(resourceName: "pinterest")
        pinterest.identifier = "menu.pinterest.identifier"
        newData.append(pinterest)
        
        let settings = MGSideMenuItem()
        settings.title = "Settings"
        settings.icon = UIImage(icon: .ionicons(IoniconsType.settings), size: CGSize(width: 30, height: 30), textColor: .white)
        settings.identifier = "menu.settings.identifier"
        newData.append(settings)
        
        return SideMenuAssets(
            string: SideMenuString(
                tableViewHeaderTitle: "Megageneral",
                tableViewHeaderSubtitle: "An unique multipurpose template"),
            font: SideMenuFont(
                tableViewHeaderTitle: nil,
                tableViewHeaderSubtitle: nil,
                tableViewCellTitle: nil),
            image: SideMenuImage(
                tableViewHeaderImage: #imageLiteral(resourceName: "MGIconLight")),
            color: SideMenuColor(
                view: MGTemplate.assets.color.sideBar,
                backgroundView: MGTemplate.assets.color.sideBar,
                tableView: MGTemplate.assets.color.sideBar,
                tableViewSeparator: MGTemplate.assets.color.sideBar,
                tableViewCell: MGTemplate.assets.color.sideBar,
                tableViewHeader: MGTemplate.assets.color.sideBar,
                tableViewCellContent: .white,
                tableViewHeaderContent: .white),
            data: SideMenuData(
                items: newData,
                statusBarStyle: .lightContent))
    }
}

struct SideMenuAssets: MGSideMenuAsset {
    var string: MGSideMenuString
    var font: MGSideMenuFont
    var image: MGSideMenuImage
    var color: MGSideMenuColor
    var data: MGSideMenuData
}

struct SideMenuString: MGSideMenuString {
    var tableViewHeaderTitle: String
    var tableViewHeaderSubtitle: String
}

struct SideMenuFont: MGSideMenuFont {
    var tableViewHeaderTitle: UIFont?
    var tableViewHeaderSubtitle: UIFont?
    var tableViewCellTitle: UIFont?
}

struct SideMenuImage: MGSideMenuImage {
    var tableViewHeaderImage: UIImage?
}

struct SideMenuColor: MGSideMenuColor {
    var view: UIColor
    var backgroundView: UIColor
    var tableView: UIColor
    var tableViewSeparator: UIColor
    var tableViewCell: UIColor
    var tableViewHeader: UIColor
    var tableViewCellContent: UIColor
    var tableViewHeaderContent: UIColor
}

struct SideMenuData:MGSideMenuData {
    var items: [MGSideMenuItem]
    var statusBarStyle: UIStatusBarStyle
}

