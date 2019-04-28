// 
//  FontLoader.swift
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

public protocol FontEnum {
    var fontName:String { get }
    var unicode:String { get }
    var error:String { get }
    func loadFontIfNeeded()
}

public class FontLoader {
    
    public static func loadFont(name:String, ext:String="ttf") {
        let bundle = Bundle(for: FontLoader.self)
        let fontURL = bundle.url(forResource: name, withExtension: ext)
        guard let furl = fontURL else {
            return
        }
        
        do {
            let data = try Data(contentsOf: furl)
            let provider = CGDataProvider(data: data as CFData)
            let font = CGFont(provider!)
            var error: Unmanaged<CFError>?
            if CTFontManagerRegisterGraphicsFont(font!, &error) == false {
                let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
                let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
                NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
            }
        } catch let error {
            print("Error loading font: \(error)")
        }
    }
    
    public static func loadFontIfNeeded(fontType : FontType) {
//        let fileName = fontType.fileName
//        let fontName = fontType.fontName
        
//        if loadedFontsTracker[fontName]! == false {
//            let bundle = Bundle.current
//            let fontURL = bundle.url(forResource: fileName, withExtension: "ttf")!
//            do {
//                let data = try Data(contentsOf: fontURL)
//                let provider = CGDataProvider(data: data as CFData)
//                let font = CGFont(provider!)!
//                var error: Unmanaged<CFError>?
//                if CTFontManagerRegisterGraphicsFont(font, &error) == false {
//                    let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
//                    let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
//                    NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
//                } else {
//                    loadedFontsTracker[fontName] = true
//                }
//            } catch let error {
//                print("Error loading font: \(error)")
//            }
//        }
    }
    
    public static func loadFontIfNeeded(_ icon: FontEnum) {
        let fn = icon.fontName
        if (UIFont.fontNames(forFamilyName: fn).count == 0) {
            icon.loadFontIfNeeded()
        }
    }
    
    public static func getFont(_ icon: FontEnum, iconSize: CGFloat ) -> UIFont {
        loadFontIfNeeded(icon)
        let font = UIFont(name: icon.fontName, size: iconSize)
        assert(font != nil, icon.error)
        return font!
    }
    
    public static func concat(prefix: String, icon: FontEnum, postfix:String ) -> String{
        return prefix + icon.unicode + postfix
    }
    
}


fileprivate var loadedFontsTracker: [String: Bool] = [
    "dripicons-v2": false,
    "emoji": false,
    "FontAwesome5FreeRegular": false,
    "FontAwesome5BrandsRegular": false,
    "FontAwesome5FreeSolid": false,
    "icofont": false,
    "Ionicons": false,
    "Linearicons-Free": false,
    "map-icons": false,
    "MaterialIcons-Regular": false,
    "open-iconic": false,
    "StateFace-Regular": false,
    "WeatherIcons-Regular": false,
    "typicons": false]

public extension UIImage {
    
    convenience init(icon: FontEnum, size: CGSize, textColor: UIColor = UIColor.black, backgroundColor: UIColor = UIColor.clear) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center
        
        // Taken from FontAwesome.io's Fixed Width Icon CSS
        let fontAspectRatio: CGFloat = 1.28571429
        let fontSize = min(size.width / fontAspectRatio, size.height)
        
        let font = FontLoader.getFont(icon, iconSize: fontSize)
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.backgroundColor: backgroundColor, NSAttributedString.Key.paragraphStyle: paragraph]
        
        let attributedString = NSAttributedString(string: icon.unicode, attributes: attributes)
        UIGraphicsBeginImageContextWithOptions(size, false , 0.0)
        attributedString.draw(in: CGRect(x: 0, y: (size.height - fontSize) / 2, width: size.width, height: fontSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!, scale: image!.scale, orientation: image!.imageOrientation)
    }
}

public extension UIBarButtonItem {
    
    func setFontIcon(_ icon: FontEnum, size: CGFloat = 23.0) {
        setFontIconText(prefix: "", icon: icon, postfix: "", size: size)
    }
    
    func setFontIconText(prefix: String, icon: FontEnum, postfix: String, size: CGFloat) {
        
        let font = FontLoader.getFont(icon, iconSize: size)
        setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        setTitleTextAttributes([NSAttributedString.Key.font: font], for: .highlighted)
        setTitleTextAttributes([NSAttributedString.Key.font: font], for: .disabled)
        #if giOS8OrGreater
        setTitleTextAttributes([NSFontAttributeName: font], for: .focused)
        #endif
        title = FontLoader.concat(prefix: prefix, icon: icon, postfix: postfix)
    }
}

public extension UIButton {
    
    func setFontIcon(_ icon: FontEnum, forState: UIControl.State) {
        if let label = titleLabel {
            setFontIcon(icon, size: label.font.pointSize, forState: forState)
        }
    }
    
    func setFontIcon(_ icon: FontEnum, size:CGFloat, forState: UIControl.State) {
        setFontIconText(prefix: "", icon: icon, postfix: "", size: size, forState: forState)
    }
    
    func setFontIconText(prefix: String, icon: FontEnum, postfix: String, size: CGFloat, forState: UIControl.State) {
        
        let font = FontLoader.getFont(icon, iconSize: size)
        
        if let label = titleLabel {
            label.font = font
            let text = FontLoader.concat(prefix: prefix, icon: icon, postfix: postfix)
            setTitle(text, for: forState)
        }
    }
}

public extension UILabel {
    
    func setFontIcon(_ icon: FontEnum, size: CGFloat = 23.0) {
        setFontIconText(prefix: "", icon: icon, postfix: "", size: size)
    }
    
    func setFontIconText(prefix: String, icon: FontEnum, postfix: String, size: CGFloat) {
        
        let font = FontLoader.getFont(icon, iconSize: size)
        self.font = font
        self.text = FontLoader.concat(prefix: prefix, icon: icon, postfix: postfix)
    }
}

public extension UIImageView {
    
    func setFontIcon(_ icon: FontEnum, textColor: UIColor, backgroundColor: UIColor = UIColor.clear) {
        
        self.image = UIImage(icon: icon, size: frame.size, textColor: textColor, backgroundColor: backgroundColor)
    }
}

public extension UITabBarItem {
    
    func setFontIcon(_ icon: FontEnum) {
        
        image = UIImage(icon: icon, size: CGSize(width: 30, height: 30))
    }
}

public extension UISegmentedControl {
    
    func setFontIcon(_ icon: FontEnum, forSegmentAtIndex segment: Int) {
        
        let font = FontLoader.getFont(icon, iconSize: 23.0)
        
        setTitleTextAttributes([NSAttributedString.Key.font: font], for: UIControl.State())
        setTitle(icon.unicode, forSegmentAt: segment)
    }
}

public extension UISlider {
    
    func setFontIconMaximumValueImage(_ icon: FontEnum, customSize: CGSize? = nil) {
        
        maximumValueImage = UIImage(icon: icon, size: customSize ?? CGSize(width: 25, height: 25))
    }
    
    func setFontIconMinimumValueImage(_ icon: FontEnum, customSize: CGSize? = nil) {
        
        minimumValueImage = UIImage(icon: icon, size: customSize ?? CGSize(width: 25, height: 25))
    }
}
