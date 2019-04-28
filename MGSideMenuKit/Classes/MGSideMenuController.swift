// 
//  MGSideMenuController.swift
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

public class MGSideMenuController: UIViewController {
    public var delegate: MGSideMenuControllerDelegate?
    public var dataSource: MGSideMenuControllerDataSource! {
        didSet {
            if let controller = _splitViewController {
                controller.viewControllers[1] = dataSource.controller(_menuController)
            }
            if let controller = _sideMenuController {
                controller.setContentViewController(to: dataSource.controller(_menuController), animated: false, completion: nil)
            }
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        _menuController.tableView.delegate = self
        _menuController.tableView.dataSource = self
    }
    
    public var assets: MGSideMenuAsset? {
        didSet {
            _menuController.assets = assets
        }
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return assets?.data.statusBarStyle ?? .default
    }
    
    public func showMenu() {
        if let controller = _splitViewController {
            let action:Selector? = controller.displayModeButtonItem.action
            let target: Any? = controller.displayModeButtonItem.target
            UIApplication.shared.sendAction(action!, to: target, from: nil, for: nil)
        }
        if let controller = _sideMenuController {
            controller.revealMenu()
        }
    }

    public func hideMenu() {
        if let controller = _splitViewController {
            let action:Selector? = controller.displayModeButtonItem.action
            let target: Any? = controller.displayModeButtonItem.target
            UIApplication.shared.sendAction(action!, to: target, from: nil, for: nil)
        }
        if let controller = _sideMenuController {
            controller.hideMenu()
        }
    }
    
    public var instance: MGSideMenuController {
        _menuController = _storyboard.instantiateViewController(withIdentifier: menuViewControllerIdentifier) as? MGMenuController

        let centerController = UIViewController()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let splitController = UISplitViewController()
            splitController.maximumPrimaryColumnWidth = 280
            _menuController.width = 280
            splitController.viewControllers = [_menuController, centerController]
            addChild(splitController)
            splitController.view.frame = view.frame
            view.addSubview(splitController.view)
            splitController.didMove(toParent: self)
            return self
        }
        
        SideMenuController.preferences.basic.menuWidth = 250
        SideMenuController.preferences.basic.statusBarBehavior = .none
        SideMenuController.preferences.basic.position = .under
        SideMenuController.preferences.basic.direction = .left
        SideMenuController.preferences.basic.enablePanGesture = true
        SideMenuController.preferences.basic.supportedOrientations = .portrait
        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
        SideMenuController.preferences.basic.defaultCacheKey = "0"
        
        let sideMenuController = SideMenuController()
        _menuController.width = 250
        sideMenuController.menuViewController = _menuController
        sideMenuController.contentViewController = centerController

        addChild(sideMenuController)
        sideMenuController.view.frame = view.frame
        view.addSubview(sideMenuController.view)
        sideMenuController.didMove(toParent: self)

        return self
    }

    private var _splitViewController: UISplitViewController? {
        return children.first(where: { $0 is UISplitViewController }) as? UISplitViewController
    }
    
    private var _sideMenuController: SideMenuController? {
        return children.first(where: { $0 is SideMenuController }) as? SideMenuController
    }

    private var _menuController: MGMenuController!

    private var _storyboard: UIStoryboard {
        let podBundle = Bundle(for: MGSideMenuController.self)
        let bundleURL = podBundle.url(forResource: resourceName, withExtension: resourceExtension)
        let bundle = Bundle(url: bundleURL!) ?? Bundle()
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard
    }
    
}

extension MGSideMenuController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "MGMenuHeaderCell") as? MGMenuHeaderCell
        header?.contentView.backgroundColor = assets?.color.tableViewHeader
        header?.backgroundColor = assets?.color.tableViewHeader
        header?.iconImageView.isHidden = assets?.image.tableViewHeaderImage == nil
        header?.iconImageView.image = assets?.image.tableViewHeaderImage
        header?.titleLabel.text = assets?.string.tableViewHeaderTitle
        header?.titleLabel.textColor = assets?.color.tableViewHeaderContent
        if let font = assets?.font.tableViewHeaderTitle {
            header?.titleLabel.font = font
        }
        header?.subtitleLabel.text = assets?.string.tableViewHeaderSubtitle
        header?.subtitleLabel.textColor = assets?.color.tableViewHeaderContent
        if let font = assets?.font.tableViewHeaderSubtitle {
            header?.titleLabel.font = font
        }
        return header?.contentView ?? MGMenuHeaderCell().contentView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assets?.data.items.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MGMenuItemCell") as? MGMenuItemCell
        let item = assets?.data.items[indexPath.row]
        cell?.contentView.backgroundColor = assets?.color.tableViewCell
        cell?.backgroundColor = assets?.color.tableViewCell
        cell?.iconImageView.isHidden = item?.icon == nil
        cell?.iconImageView.image = item?.icon
        cell?.titleLabel.text = item?.title
        cell?.titleLabel.textColor = assets?.color.tableViewCellContent
        if let font = assets?.font.tableViewCellTitle {
            cell?.titleLabel.font = font
        }
        return cell ?? MGMenuItemCell()
    }
        
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = assets?.data.items[indexPath.row] else { return }

        delegate?.controller(_menuController, didSelectItem: item, atIndexPath: indexPath)
        
        if delegate?.controller(_menuController, canSelectItem: item, atIndexPath: indexPath) == true {
            hideMenu()
        }
        
        if let centerController = dataSource.controller(_menuController, forIndexPath: indexPath, withItem: item) {
            if let controller = _splitViewController {
                controller.viewControllers[1] = centerController
            } else if let controller = _sideMenuController {
                controller.setContentViewController(to: centerController, animated: false, completion: nil)
            }
        }
    }
    
}

public class MGMenuItemCell: UITableViewCell {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.layer.cornerRadius = 1
    }
}

public class MGMenuHeaderCell: UITableViewCell {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    override public func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 3
        iconImageView.clipsToBounds = true
    }
}

fileprivate let menuViewControllerIdentifier = "MGMenuController"
fileprivate let storyboardName = "MGSideMenu"
fileprivate let resourceName = "MGSideMenuKit"
fileprivate let resourceExtension = "bundle"
