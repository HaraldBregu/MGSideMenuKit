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
    var headerIcon: UIImage!
    var data:[MGSideMenuData] = []
    var didSelectMenuDataAtIndexPath:((MGSideMenuData, IndexPath) -> ())!

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = MGGeneral.NavBar.Theme.dark
        navigationController?.isNavigationBarHidden = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        //tableView.backgroundColor = MGGeneral.NavBar.Theme.dark
        //tableView.separatorColor = MGGeneral.NavBar.Theme.dark
        
        view.backgroundColor = .yellow
        tableView.backgroundColor = .yellow
        tableView.separatorColor = .yellow
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

/// :nodoc:
extension MGMenuController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderViewCell") as? MenuHeaderViewCell else {
            return UITableViewCell()
        }
        
        header.titleLabel.text = headerTitle
        header.iconImageView.image = headerIcon

//        header.contentView.backgroundColor = MGGeneral.NavBar.Theme.dark
//        header.backgroundColor = MGGeneral.NavBar.Theme.dark
        return header
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as? MenuItemCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = item.title
        cell.iconImageView.image = item.icon
        cell.iconImageView.isHidden = item.icon == nil
        cell.titleLabel.textColor = .white
        return cell
    }
}

extension MGMenuController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        self.sideMenuController?.hideMenu()
        didSelectMenuDataAtIndexPath(item, indexPath)
    }
}

///// :nodoc:
//extension MGMenuController: SideMenuControllerDelegate {
//
//    public func sideMenuControllerDidHideMneu(_ sideMenuController: SideMenuController) {
//
//    }
//
//    public func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
//
//    }
//
//    public func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
//
//    }
//
//    public func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
//
//    }
//
//    public func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
//
//    }
//
//    public func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
//
//    }
//
//    public func sideMenuController(_ sideMenuController: SideMenuController, animationControllerFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
//    }
//
//}

/// :nodoc:
class MenuHeaderViewCell: UITableViewCell {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 3
        iconImageView.clipsToBounds = true
//        titleLabel.font = MGGeneral.Font.bold(size: 20.0)
    }
}

/// :nodoc:
class MenuItemCell: UITableViewCell {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentView.backgroundColor = MGGeneral.NavBar.Theme.dark
//        backgroundColor = MGGeneral.NavBar.Theme.dark
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        titleLabel.font = MGGeneral.Font.medium(size: 16.0)
        iconImageView.layer.cornerRadius = 1
    }
}

/// :nodoc:
class MenuFooterViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentView.backgroundColor = MGGeneral.NavBar.Theme.dark
//        backgroundColor = MGGeneral.NavBar.Theme.dark
    }
}
