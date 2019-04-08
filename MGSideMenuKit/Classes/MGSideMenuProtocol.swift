// 
//  MGSideMenuProtocol.swift
//
//  Created by harald bregu on 06/04/2019.
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

public protocol MGSideMenuProtocol {
    func showMenu()
}

extension MGSideMenuProtocol where Self: UIViewController {
    
    public func showMenu() {
        if let parentController = self.parent {
            
            if parentController.isKind(of: UINavigationController.self) {
                guard let navigationController = parentController as? UINavigationController else { return }
                guard let navigationControllerParent = navigationController.parent else { return }
                
                if navigationControllerParent.isKind(of: MGSplitController.self) {
                    guard let splitController = navigationControllerParent as? MGSplitController else { return }
                    self.use(controller: splitController)
                }
                else if navigationControllerParent.isKind(of: SideMenuController.self) {
                    guard let sideMenuController = navigationControllerParent as? SideMenuController else { return }
                    self.use(controller: sideMenuController)
                }
            }
            else if parentController.isKind(of: MGSplitController.self) {
                guard let splitController = parent as? MGSplitController else { return }
                self.use(controller: splitController)
            }
            else if parentController.isKind(of: SideMenuController.self) {
                guard let sideMenuController = parent as? SideMenuController else { return }
                self.use(controller: sideMenuController)
            }
        } else {
            if self.isKind(of: UINavigationController.self) {
                guard let navigationController = self as? UINavigationController else { return }
                guard let navigationControllerParent = navigationController.parent else { return }
                
                if navigationControllerParent.isKind(of: MGSplitController.self) {
                    guard let splitController = navigationControllerParent as? MGSplitController else { return }
                    self.use(controller: splitController)
                }
                else if navigationControllerParent.isKind(of: SideMenuController.self) {
                    guard let sideMenuController = navigationControllerParent as? SideMenuController else { return }
                    self.use(controller: sideMenuController)
                }
            }
            else if self.isKind(of: MGMenuController.self) {
                if let parent = self.parent {                    
                    if parent.isKind(of: MGSplitController.self) {
                        guard let splitController = parent as? MGSplitController else { return }
                        self.use(controller: splitController)
                    }
                    else if parent.isKind(of: SideMenuController.self) {
                        guard let sideMenuController = parent as? SideMenuController else { return }
                        self.use(controller: sideMenuController)
                    }

                } else {
                    self.sideMenuController?.revealMenu()
                }
            }
            else if self.isKind(of: MGSplitController.self) {
                guard let splitController = parent as? MGSplitController else { return }
                self.use(controller: splitController)
            }
            else if self.isKind(of: SideMenuController.self) {
                guard let sideMenuController = parent as? SideMenuController else { return }
                self.use(controller: sideMenuController)
            }
        }
    }
    
    func use(controller:MGSplitController) {
        UIApplication.shared.sendAction(controller.displayModeButtonItem.action!, to: controller.displayModeButtonItem.target, from: nil, for: nil)
    }
    
    func use(controller:SideMenuController) {
        controller.revealMenu()
    }
    
}
