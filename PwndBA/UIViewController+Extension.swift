//
//  UIViewController+Extension.swift
//  PwnDemo
//
//  Created by Martin Prusa on 3/17/18.
//  Copyright © 2018 Martin Prusa. All rights reserved.
//

import UIKit

private let swizzling: (UIViewController.Type) -> () = { viewController in
    
    let originalSelector = #selector(viewController.viewDidAppear(_:))
    let swizzledSelector = #selector(viewController.proj_viewDidAppear(animated:))
    
    let originalMethod = class_getInstanceMethod(viewController, originalSelector)
    let swizzledMethod = class_getInstanceMethod(viewController, swizzledSelector)
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

extension UIViewController {
    
    open override class func initialize() {
        // make sure this isn't a subclass
        guard self === UIViewController.self else { return }
        swizzling(self)
    }
    
    // MARK: - Method Swizzling
    
    func proj_viewDidAppear(animated: Bool) {
        self.proj_viewDidAppear(animated: animated)
        
        let pwnUI = PwnUI()
        pwnUI.addDebugLabel()
        
        let viewControllerName = NSStringFromClass(type(of: self))
        let text = pwnUI.debugLabel().text!
        pwnUI.debugLabel().text = "\(text ) \n \(viewControllerName)"
        
        if viewControllerName == "AuthenticatorRelease.OneButtonViewController" {
            let selector = NSSelectorFromString("circleView")
            let unknownObj = perform(selector)
            guard let object = unknownObj, let objVal = object.takeRetainedValue() as? UIView else {
                NSLog("unknown error with circleView (probably not UIView)")
                return
            }

            let circleName = NSStringFromClass(type(of: objVal))
            NSLog("circleView: \(circleName)")
        }
        
        NSLog("viewWillAppear: \(viewControllerName)")
    }
}
