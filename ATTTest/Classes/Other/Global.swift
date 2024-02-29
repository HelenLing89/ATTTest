//
//  Global.swift
//  外高桥紫薇花园
//
//  Created by 凌甜 on 2021/3/16.
//

import UIKit
public  let kW = UIScreen.main.bounds.width / 1366 * 0.5
public let kH = UIScreen.main.bounds.height / 1024 * 0.5

public let kScreenW = UIScreen.main.bounds.width
public let kScreenH = UIScreen.main.bounds.height

public let kScreenBound = UIScreen.main.bounds

public let imagePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first

public func kARGBColor(a: CGFloat ,r: CGFloat, g: CGFloat, b:CGFloat) -> UIColor {
    UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
public typealias coloerFn = (CGFloat,CGFloat,CGFloat,CGFloat) -> UIColor
public let kARGB: coloerFn = kARGBColor
public let changeRootNotification = "changeRootNotification"

