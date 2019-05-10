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

public protocol MGSideMenuAsset {
    var string: MGSideMenuString { get set }
    var font: MGSideMenuFont { get set }
    var image: MGSideMenuImage { get set }
    var color: MGSideMenuColor { get set }
    var data: MGSideMenuData { get set }
}

public protocol MGSideMenuString {
    var tableViewHeaderTitle: String { get set }
    var tableViewHeaderSubtitle: String { get set }
    var tableViewFooterTitle: String { get set }
}

public protocol MGSideMenuFont {
    var tableViewHeaderTitle: UIFont? { get set }
    var tableViewHeaderSubtitle: UIFont? { get set }
    var tableViewCellTitle: UIFont? { get set }
    var tableViewFooterTitle: UIFont? { get set }
}

public protocol MGSideMenuImage {
    var tableViewHeaderImage: UIImage? { get set }
}

public protocol MGSideMenuColor {
    var view: UIColor { get set }
    var backgroundView: UIColor { get set }
    var tableView: UIColor { get set }
    var tableViewSeparator: UIColor { get set }
    var tableViewCell: UIColor { get set }
    var tableViewHeader: UIColor { get set }
    var tableViewFooter: UIColor { get set }
    var tableViewCellContent: UIColor { get set }
    var tableViewHeaderContent: UIColor { get set }
    var tableViewFooterContent: UIColor { get set }
}

public protocol MGSideMenuData {
    var items: [MGSideMenuItem] { get set }
    var statusBarStyle: UIStatusBarStyle { get set }
}

public class MGSideMenuItem {
    public var title: String!
    public var icon: UIImage?
    public var identifier: String!
    public var data: Any?
    public init() {}
}
