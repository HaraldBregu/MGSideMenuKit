// 
//  MGSideMenu.swift
//
//  Created by harald bregu on 11/03/2019.
//  Copyright © 2019 Dream Building Company. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import SideMenuSwift

public class MGSideMenu {
    
    public init(dataSource: MGSideMenuDataSource, delegate: MGSideMenuDataDelegate) {
        self.dataSource = dataSource
        self.delegate = delegate
        
        SideMenuController.preferences.basic.menuWidth = 240
        SideMenuController.preferences.basic.statusBarBehavior = .none
        SideMenuController.preferences.basic.position = .under
        SideMenuController.preferences.basic.direction = .left
        SideMenuController.preferences.basic.enablePanGesture = true
        SideMenuController.preferences.basic.supportedOrientations = .all
        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
        SideMenuController.preferences.basic.defaultCacheKey = "0"

        self.containerController = _containerController
        self.menuController = _menuController
        self.centerController = _centerController
    }
    
    public var containerController: UIViewController!
    private var menuController: MGMenuController!
    private var centerController: MGCenterController!
    private var dataSource: MGSideMenuDataSource!
    private var delegate: MGSideMenuDataDelegate!
}

extension MGSideMenu {
    
    // MARK - ContainerController

    private var _containerController: UIViewController? {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .unspecified:
            return SideMenuController(contentViewController: dataSource.primaryController ?? _centerController, menuViewController: _menuController)
        case .phone:
            return SideMenuController(contentViewController: dataSource.primaryController ?? _centerController, menuViewController: _menuController)
        case .pad:
            let splitController = _splitController
            splitController.maximumPrimaryColumnWidth = 240
            splitController.viewControllers = [_menuController, dataSource.primaryController ?? _centerController]
            return splitController
        case .tv:
            return SideMenuController(contentViewController: dataSource.primaryController ?? _centerController, menuViewController: _menuController)
        case .carPlay:
            return SideMenuController(contentViewController: dataSource.primaryController ?? _centerController, menuViewController: _menuController)
        }
    }
    
    // MARK - SplitController
    
    private var _splitController: MGSplitController {
        guard let splitController = _storyboard.instantiateViewController(withIdentifier: "MGSplitController") as? MGSplitController else { return MGSplitController() }
        return splitController
    }
    
    // MARK - MenuController

    private var _menuController: MGMenuController {
        guard let controller = _menuViewController else { return MGMenuController() }
        controller.data = dataSource.data
        controller.items = dataSource.items
        controller.layout = dataSource.layout
        controller.didSelectMenuItemAtIndexPath = { [unowned self] (controller, item, indexPath) in
            self.delegate.menuController(controller, didSelectItem:item, atIndexPath:indexPath)
        }
        controller.canCloseMenuAtIndexPath = { [unowned self] (controller, indexPath) -> Bool in
            return self.delegate.menuController(controller, canCloseMenuAtIndexPath:indexPath)
        }
        controller.controllerForIndexPath = { [unowned self] (controller, item, indexPath) -> UIViewController? in
            return self.dataSource.centerController(item: item, forIndexPath: indexPath)
        }
        return controller
    }

    private var _menuViewController: MGMenuController? {
        return _storyboard.instantiateViewController(withIdentifier: menuViewControllerIdentifier) as? MGMenuController
    }

    // MARK - CenterController
    
    private var _centerController: MGCenterController {
        guard let controller = _centerViewController else { return MGCenterController() }
        return controller
    }

    private var _centerViewController: MGCenterController? {
        return _storyboard.instantiateViewController(withIdentifier: centerViewControllerIdentifier) as? MGCenterController
    }
    
    // MARK - Storyboard
    
    private var _storyboard:UIStoryboard {
        return UIStoryboard(name: _storyboardName, bundle: _storyboardBundle)
    }
    
    private var _storyboardName:String {
        return storyboardName
    }
    
    private var _storyboardBundle:Bundle {
        let podBundle = Bundle(for: MGSideMenu.self)
        let bundleURL = podBundle.url(forResource: resourceName, withExtension: resourceExtension)
        let bundle = Bundle(url: bundleURL!)!
        return bundle
    }

}

fileprivate let storyboardName = "MGSideMenu"
fileprivate let menuViewControllerIdentifier = "MGMenuController"
fileprivate let centerViewControllerIdentifier = "MGCenterController"
fileprivate let resourceName = "MGSideMenuKit"
fileprivate let resourceExtension = "bundle"

