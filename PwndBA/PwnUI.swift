//
//  PwnUI.swift
//  PwnDemo
//
//  Created by Martin Prusa on 3/17/18.
//  Copyright © 2018 Martin Prusa. All rights reserved.
//

import UIKit

let lblTag = 99999
let pwnText = "<---- Pwned by Martin Prusa!!! ---->"

open class PwnUI: NSObject {
    @objc open func hijackAppWindow(){        
        addDebugLabel()
    }
    
    open func appWindow() -> UIWindow? {
        guard let delegate = UIApplication.shared.delegate else{
            return nil
        }
        guard let window = delegate.window, let windowNotNil = window else {
            return nil
        }
        
        return windowNotNil
    }
    
    open func addDebugLabel() {
        guard let window = self.appWindow() else {
            return
        }
        
        if let existingHijackView = window.viewWithTag(lblTag) {
            existingHijackView.removeFromSuperview()
        }

        let label = UILabel(frame: CGRect(x: 0,y: 0, width: window.frame.size.width, height: 130))
        label.text = pwnText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.yellow
        label.tag = lblTag

        window.addSubview(label)
    }
    
    open func debugLabel() -> UILabel {        
        let window = self.appWindow()!
        
        if let existingHijackView = window.viewWithTag(lblTag) as? UILabel {
            return existingHijackView
        }
        
        addDebugLabel()
        return (window.viewWithTag(lblTag) as! UILabel)
    }
}
