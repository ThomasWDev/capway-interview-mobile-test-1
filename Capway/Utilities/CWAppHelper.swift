//
//  CMAppHelper.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

func DLog<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if DEBUG
    let fileString = file as NSString
    let fileLastPathComponent = fileString.lastPathComponent as NSString
    let filename = fileLastPathComponent.deletingPathExtension
    print("\(filename).\(function)[\(line)]: \(object)\n", terminator: "")
    #endif
}

typealias DictString = [String:String]

struct RootVCHelper {
    
    static func setToDashboardVC() {
        let storyboard = UIStoryboard(storyboard: .dashboard)
        let vc = storyboard.instantiateViewController(withIdentifier: CWDashboardVC.self)
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let navigationController = UINavigationController(rootViewController: vc)
            appDelegate.window?.rootViewController = navigationController
            keyWindow?.rootViewController = navigationController
            keyWindow?.makeKeyAndVisible()
        } else {
            let sb = UIStoryboard(storyboard: .dashboard)
            let vc = sb.instantiateViewController(withIdentifier: CWDashboardVC.self)
            
            let transition = CATransition()
            transition.type = CATransitionType.fade
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let navigationController = UINavigationController(rootViewController: vc)
            appDelegate.window?.rootViewController = navigationController
            UIApplication.shared.keyWindow?.set(rootViewController: vc, withTransition: transition)
        }
    }    
}


