//
//  AFSessionManager.swift
//  外高桥紫薇花园
//
//  Created by 凌甜 on 2021/3/17.
//

import UIKit

class AFSessionManager: AFHTTPSessionManager {
    static let  manager : AFSessionManager = {
       let mgr = AFSessionManager()
        mgr.responseSerializer = AFHTTPResponseSerializer()
        return mgr
    }()
}
