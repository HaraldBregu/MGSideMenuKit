// 
//  MGMenuController.swift
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

import UIKit
import SideMenuSwift

public class MGMenuController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var headerTitle: String!
    var headerIcon: UIImage?
    var data:[MGSideMenuData] = []
    var layout:MGSideMenuLayout!

    var didSelectMenuDataAtIndexPath:((MGMenuController, MGSideMenuData, IndexPath) -> ())!
    var canCloseMenuAtIndexPath:((MGMenuController, IndexPath) -> (Bool))!
    var controllerForIndexPath:((MGMenuController, MGSideMenuData, IndexPath) -> (UIViewController?))!

    override public func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = layout.backgroundColor
        navigationController?.isNavigationBarHidden = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = layout.backgroundColor
        tableView.separatorColor = layout.backgroundColor
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

/// :nodoc:
extension MGMenuController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: "MGMenuHeaderCell") as? MGMenuHeaderCell else {
            return UITableViewCell()
        }
        
        header.contentView.backgroundColor = layout.backgroundColor
        header.backgroundColor = layout.backgroundColor

        header.iconImageView.isHidden = headerIcon == nil
        header.iconImageView.image = headerIcon

        header.titleLabel.font = layout.font
        header.titleLabel.text = headerTitle

        return header
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MGMenuItemCell") as? MGMenuItemCell else {
            return UITableViewCell()
        }

        let item = data[indexPath.row]

        cell.contentView.backgroundColor = layout.backgroundColor
        cell.backgroundColor = layout.backgroundColor

        cell.iconImageView.isHidden = item.icon == nil
        cell.iconImageView.image = item.icon

        cell.titleLabel.text = item.title
        cell.titleLabel.textColor = layout.tintColor
        
        return cell
    }
}

extension MGMenuController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        
        didSelectMenuDataAtIndexPath(self, item, indexPath)
        if canCloseMenuAtIndexPath(self, indexPath) {
            sideMenuController?.hideMenu()
        }

        if let controller = controllerForIndexPath(self, item, indexPath) {
            sideMenuController?.setContentViewController(to: controller, animated: false, completion: nil)
            if UIDevice.current.userInterfaceIdiom == .pad {
                self.splitViewController?.viewControllers[1] = controller
            }
        }

    }
}
