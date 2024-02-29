//
//  String-Extension.swift
//  外高桥紫薇花园
//
//  Created by 凌甜 on 2021/3/16.
//

import UIKit

public extension String {
    static func ATTFileNameWIthStr(str: String)-> String {
        #if DEBUG
        let fileName1 = String.init(format: "Images/\(str)", [])
        let fileName = Bundle.main.path(forResource: fileName1, ofType: nil)!
        #else
        let fileName = String.init(format: "\(imagePath)/\(str)", []) ??  "1"
       #endif
        return fileName
    }
}
