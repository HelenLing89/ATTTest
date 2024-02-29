//
//  TimeCheckTool.swift
//  外高桥紫薇花园
//
//  Created by 凌甜 on 2021/3/16.
//

import UIKit

let tag0 = "currentDate"
let datePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!.appending("/date.plist")
class TimeCheckTool: NSObject {
    var dataDic:NSDictionary?
    static let shareTimeTool:TimeCheckTool = TimeCheckTool()
    override init() {
        super.init()
        let pathArray = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let pathStr = pathArray.first
        let filePath = (pathStr! as NSString).appendingPathComponent("date.plist")
//        let sandBoxDateDic = NSMutableDictionary.init(contentsOfFile: filePath)
//        guard sandBoxDateDic != nil else {
//            return
//        }
        let fm = FileManager.default
        fm.createFile(atPath: filePath, contents: nil, attributes: nil)
        let dic = NSMutableDictionary.init()
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dic[tag0] = "2021-6-22"
        dic.write(toFile: filePath, atomically: true)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TimeCheckTool {
    func timeCheckToolWithWebSite(str:String) {
        let dic1 = NSMutableDictionary.init(contentsOfFile: datePath)!
        AFSessionManager.manager.get(str, parameters: nil, headers: nil, progress: nil) { (task, resposeObj) in
            guard let resposeData = resposeObj else {
                return
            }
            self.dataDic = (try? JSONSerialization.jsonObject(with: resposeData as! Data, options:.mutableContainers)) as? NSDictionary
            
            guard let dataDic = self.dataDic else {
                return
            }
           let str = dataDic["date"] as! String
            let str1 = dic1[tag0] as! String
            if str == str1 {
                dic1[tag0] = str
                dic1.write(toFile: datePath, atomically: true)
            }
            self.setTimeWithStr(str: str)
        } failure: { (dataTask, error) in
            let str2 = dic1[tag0]
            self.setTimeWithStr(str: str2 as! String)
        }

    }
    
    private func setTimeWithStr(str:String) {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let anotherDate = dateFormatter.date(from: str)
        guard let anOtherDate = anotherDate else {
            return
        }
        let pass = compareDay(oneDay:Date.init(), anotherDay: anOtherDate)
        if pass == 1 {
            let topWindow = UIWindow.init(frame: UIScreen.main.bounds)
            topWindow.rootViewController = UIViewController.init()
            topWindow.windowLevel = UIWindow.Level.alert + 1
            let alert = UIAlertController.init(title: "提示", message: "您的APP使用已经到期,请联系开发人员", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "知道了", style: .default) { (_) in
                topWindow.isHidden = true
                exit(0)
            }
            alert.addAction(action)
            topWindow.makeKeyAndVisible()
            topWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
   private func compareDay(oneDay:Date, anotherDay:Date) -> NSInteger {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let oneDayStr = dateFormatter.string(from: oneDay)
        let anotherDayStr = dateFormatter.string(from: anotherDay)
        let dateA = dateFormatter.date(from: oneDayStr)
        let dateB = dateFormatter.date(from: anotherDayStr)
        guard let newDateA = dateA, let newDateB = dateB else {
            return 1
        }
        let result = newDateA.compare(newDateB)
        switch result {
        case .orderedDescending:
            return 1
        case .orderedAscending:
            return -1
        default:
            return 1
        }
        
        
        
    }
    
}
