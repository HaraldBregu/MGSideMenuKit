// 
//  Template.swift
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
import MGTemplateKit

class Template {}

extension Template: TemplateAssetsData {}

protocol TemplateAssetsData {
    static var `default`: TemplateAssets { get }
    static var light: TemplateAssets { get }
    static var dark: TemplateAssets { get }
}

struct TemplateAssets: MGTemplateAssets {
    var color: MGTemplateColor
    var font: MGTemplateFont
}

struct TemplateColor: MGTemplateColor {
    var view: UIColor
    var navigationBar: UIColor
    var toolBar: UIColor
    var sideBar: UIColor
    var scrollView: UIColor
    var tableView: UIColor
    var tableViewCell: UIColor
    var tableViewSeparator: UIColor
    var tableViewHeader: UIColor
    var tableViewFooter: UIColor
    var tableViewHeaderSection: UIColor
    var tableViewFooterSection: UIColor
    var collectionView: UIColor
    var collectionViewCell: UIColor
    var collectionViewHeader: UIColor
    var collectionViewFooter: UIColor
    var collectionViewHeaderSection: UIColor
    var collectionViewFooterSection: UIColor
    var activityIndicator: UIColor
    var text: MGTemplateColorText
}

struct TemplateColorText: MGTemplateColorText {
    var navigationBar: UIColor
    var toolBar: UIColor
    var primary: UIColor
    var secondary: UIColor
    var placeholder: UIColor
    var disabled: UIColor
    var error: UIColor
}

struct TemplateFont: MGTemplateFont {
    var navigationBar: UIFont
    var toolBar: UIFont
    var primary: UIFont
    var secondary: UIFont
    var placeholder: UIFont
    var disabled: UIFont
    var error: UIFont
}
