// 
//  MGTemplate.swift
//
//  Created by harald bregu on 08/03/2019.
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
import UIColor_Hex_Swift
import FontBlaster

public class MGTemplate {
    public static var assets: MGTemplateAssets!
    public static var color: MGTemplateColor!
    public static var font: MGTemplateFont!

    public static func setup(assets: MGTemplateAssets) {
        FontBlaster.blast(bundle: Bundle(for: MGTemplate.self))
        MGTemplate.assets = assets
        MGTemplate.color = assets.color
        MGTemplate.font = assets.font
    }

    private static let darkColor = UIColor("#15161D")
    private static let contentColor = UIColor("#F3F7F8")

    public struct NavigationBar {
        public static let backgroundColor = darkColor
        public static let tintColor = contentColor
    }

    public struct View {
        public static let backgroundColor = darkColor
        public static let tintColor = contentColor
    }

    public class Font {
        private var size:CGFloat!
        private var weight:String!
        
        public init(size: CGFloat) {
            self.size = size
        }
        
        public var medium:UIFont? {
            weight = "Medium"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
        
        public var light:UIFont? {
            weight = "Light"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
        
        public var regular:UIFont? {
            weight = "Regular"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
        
        public var mediumItalic:UIFont? {
            weight = "MediumItalic"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
        
        public var thinItalic:UIFont? {
            weight = "ThinItalic"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
        
        public var boldItalic:UIFont? {
            weight = "BoldItalic"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
        
        public var lightItalic:UIFont? {
            weight = "LightItalic"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
        
        public var italic:UIFont? {
            weight = "Italic"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
        
        public var blackItalic:UIFont? {
            weight = "BlackItalic"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
        
        public var bold:UIFont? {
            weight = "Bold"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
        
        public var thin:UIFont? {
            weight = "Thin"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
        
        public var black:UIFont? {
            weight = "Black"
            return UIFont(name: "Roboto" + "-" + weight, size: size)
        }
    }
}
