// 
//  DefaultTemplate.swift
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

extension Template {
    
    static var `default`: TemplateAssets {
        
        return TemplateAssets(
            color: TemplateColor(
                view: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                navigationBar: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                toolBar: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                sideBar: #colorLiteral(red: 0.07309625613, green: 0.06932412941, blue: 0.1093190402, alpha: 1),
                scrollView: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                tableView: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                tableViewCell: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                tableViewSeparator: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                tableViewHeader: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                tableViewFooter: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                tableViewHeaderSection: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                tableViewFooterSection: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                collectionView: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                collectionViewCell: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                collectionViewHeader: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                collectionViewFooter: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                collectionViewHeaderSection: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                collectionViewFooterSection: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.2509803922, alpha: 1),
                activityIndicator: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                text: TemplateColorText(
                    navigationBar: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                    toolBar: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                    primary: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                    secondary: #colorLiteral(red: 0.9529411765, green: 0.968627451, blue: 0.9725490196, alpha: 0.7065681379),
                    placeholder: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                    disabled: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                    error: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))),
            font: TemplateFont(
                navigationBar: UIFont(),
                toolBar: UIFont(),
                primary: UIFont(),
                secondary: UIFont(),
                placeholder: UIFont(),
                disabled: UIFont(),
                error: UIFont()))
        
    }
    
}
