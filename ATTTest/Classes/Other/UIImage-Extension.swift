//
//  UIImage-Extension.swift
//  外高桥紫薇花园
//
//  Created by 凌甜 on 2021/3/16.
//

import UIKit

public extension UIImage {
    @objc static func imageWithName(str: String,with path:String) -> UIImage {
        #if DEBUG
        let str1 = String.init(format: "Images/\(path)/\(str)", [])
        let contentFile = Bundle.main.path(forResource: str1, ofType: nil)
        #else
        let contentFile = String.init(format: "\(imagePath)/\(path)/\(str)", [])
        #endif
        if  contentFile == nil  {
            return UIImage.init()
        }
        return UIImage.init(contentsOfFile: contentFile)!
    }
}

