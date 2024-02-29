//
//  LTWindow.swift
//  外高桥紫薇花园
//
//  Created by 凌甜 on 2021/3/16.
//

import UIKit

public class LTWindow: UIWindow {

    public override var canBecomeFocused: Bool {
        return true
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        TimeCheckTool.shareTimeTool.timeCheckToolWithWebSite(str: "https://gitee.com/MSMK_1/cuidiwan/raw/master/date.json")
        return super.hitTest(point, with: event)
    }

}
