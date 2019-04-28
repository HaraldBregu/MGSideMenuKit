// 
//  MGTemplateAssets.swift
//
//  Created by harald bregu on 28/04/2019.
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

public protocol MGTemplateAssets {
    var color: MGTemplateColor { get set }
    var font: MGTemplateFont { get set }
}

public protocol MGTemplateColor {
    var view: UIColor { get set }
    var navigationBar: UIColor { get set }
    var toolBar: UIColor { get set }
    var sideBar: UIColor { get set }
    var scrollView: UIColor { get set }
    var tableView: UIColor { get set }
    var tableViewCell: UIColor { get set }
    var tableViewSeparator: UIColor { get set }
    var tableViewHeader: UIColor { get set }
    var tableViewFooter: UIColor { get set }
    var tableViewHeaderSection: UIColor { get set }
    var tableViewFooterSection: UIColor { get set }
    var collectionView: UIColor { get set }
    var collectionViewCell: UIColor { get set }
    var collectionViewHeader: UIColor { get set }
    var collectionViewFooter: UIColor { get set }
    var collectionViewHeaderSection: UIColor { get set }
    var collectionViewFooterSection: UIColor { get set }
    var activityIndicator: UIColor { get set }
    var text: MGTemplateColorText { get set }
}

public protocol MGTemplateFont {
    var navigationBar: UIFont { get set }
    var toolBar: UIFont { get set }
    var primary: UIFont { get set }
    var secondary: UIFont { get set }
    var placeholder: UIFont { get set }
    var disabled: UIFont { get set }
    var error: UIFont { get set }
}

public protocol MGTemplateColorText {
    var navigationBar: UIColor { get set }
    var toolBar: UIColor { get set }
    var primary: UIColor { get set }
    var secondary: UIColor { get set }
    var placeholder: UIColor { get set }
    var disabled: UIColor { get set }
    var error: UIColor { get set }
}
