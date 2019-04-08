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
    public var containerController: UIViewController!

    public init() {}
    
    public var dataSource: MGSideMenuDataSource! {
        didSet {
            self.containerController = _containerController
        }
    }
    
    public var delegate: MGSideMenuDataDelegate!
}

extension MGSideMenu {
    
    private var _containerController: UIViewController? {
       
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            return _splitController
        }
        
        SideMenuController.preferences.basic.menuWidth = 240
        SideMenuController.preferences.basic.statusBarBehavior = .none
        SideMenuController.preferences.basic.position = .under
        SideMenuController.preferences.basic.direction = .left
        SideMenuController.preferences.basic.enablePanGesture = true
        SideMenuController.preferences.basic.supportedOrientations = .portrait
        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
        SideMenuController.preferences.basic.defaultCacheKey = "0"
        
        return _sideController
    }
    
    private var _sideController: SideMenuController {
        let controller = _menuController
        let centerController = dataSource.primaryCenterController(fromController: controller)
        
        let sideMenuController = SideMenuController()
        sideMenuController.contentViewController = centerController
        sideMenuController.menuViewController = controller
        
        return sideMenuController
    }
    
    private var _splitController: MGSplitController {
        let controller = _menuController
        let centerController = dataSource.primaryCenterController(fromController: controller)

        guard let splitController = _storyboard.instantiateViewController(withIdentifier: splitViewControllerIdentifier) as? MGSplitController else { return MGSplitController() }
        splitController.maximumPrimaryColumnWidth = 240
        splitController.viewControllers = [controller, centerController]
        return splitController
    }
    
    private var _menuController: MGMenuController {
        guard let controller = _storyboard.instantiateViewController(withIdentifier: menuViewControllerIdentifier) as? MGMenuController else { return MGMenuController() }
        controller.data = dataSource.data
        controller.items = dataSource.items
        controller.layout = dataSource.layout
        controller.didSelectMenuItemAtIndexPath = { (controller, item, indexPath) in
            self.delegate.menuController(controller, didSelectItem:item, atIndexPath:indexPath)
        }
        controller.canCloseMenuAtIndexPath = { [unowned self] (controller, indexPath) -> Bool in
            return self.delegate.menuController(controller, canCloseMenuAtIndexPath:indexPath)
        }
        controller.controllerForIndexPath = { [unowned self] (controller, item, indexPath) -> UIViewController? in
            return self.dataSource.centerController(item: item, forIndexPath: indexPath, fromController: controller)
        }
        
        return controller
    }

    private var _storyboard:UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: _storyboardBundle)
    }
    
    private var _storyboardBundle:Bundle {
        let podBundle = Bundle(for: MGSideMenu.self)
        let bundleURL = podBundle.url(forResource: resourceName, withExtension: resourceExtension)
        let bundle = Bundle(url: bundleURL!)!
        return bundle
    }

}

fileprivate let menuViewControllerIdentifier = "MGMenuController"
fileprivate let centerViewControllerIdentifier = "MGCenterController"
fileprivate let splitViewControllerIdentifier = "MGSplitController"
fileprivate let storyboardName = "MGSideMenu"
fileprivate let resourceName = "MGSideMenuKit"
fileprivate let resourceExtension = "bundle"
