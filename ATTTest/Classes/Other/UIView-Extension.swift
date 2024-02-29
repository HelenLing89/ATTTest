//
//  UIView-Extension.swift
//  外高桥紫薇花园
//
//  Created by 凌甜 on 2021/3/16.
//

import UIKit
public extension UIView {
    @objc  var k_X:CGFloat {
        set {
            frame.origin.x = newValue
        }
        get {
            return frame.origin.x
        }
    }
    
    @objc var k_Y:CGFloat {
        set {
            frame.origin.y = newValue
        }
        get {
            return frame.origin.y
        }
    }
    
    @objc var k_Width:CGFloat {
        set {
            frame.size.width = newValue
        }
        get {
            return frame.size.width
        }
    }
    
    @objc var k_Height:CGFloat {
        set {
            frame.size.height = newValue
        }
        get {
            return frame.size.height
        }
    }
    
    var k_Size:CGSize {
        set {
            frame.size = newValue
        }
        get {
            return frame.size
        }
    }
}
