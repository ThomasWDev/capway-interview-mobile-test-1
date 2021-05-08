//
//  UIAlertController+Show.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit


extension UIAlertController {
    
    func show() {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            if let visibleViewController = keyWindow?.visibleViewController() {
                DispatchQueue.main.async(execute: {
                    visibleViewController.present(self, animated: true, completion: nil)
                })
            } else {
                DLog("Can not show AlertController As there is no visibleViewController")
            }
        } else {
            if let visibleViewController = UIApplication.shared.keyWindow?.visibleViewController() {
                DispatchQueue.main.async(execute: {
                    visibleViewController.present(self, animated: true, completion: nil)
                })
            } else {
                DLog("Can not show AlertController As there is no visibleViewController")
            }
        }
    }
    
}
