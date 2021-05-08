//
//  Window+VisibleVC.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

extension UIWindow {
    
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController  = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(rootViewController)
            
        }
        return nil
    }
    
    class func getVisibleViewControllerFrom(_ vc:UIViewController) -> UIViewController {
        
        var nextOnStackViewController: UIViewController? = nil
        if let presented = vc.presentedViewController {
            nextOnStackViewController = presented
        } else if let navigationController = vc as? UINavigationController,
            let visible = navigationController.visibleViewController {
            nextOnStackViewController = visible
        } else if let tabBarController = vc as? UITabBarController,
            let visible = (tabBarController.selectedViewController ??
                tabBarController.presentedViewController) {
            nextOnStackViewController = visible
        }
        
        if let nextOnStackViewController = nextOnStackViewController {
            return getVisibleViewControllerFrom(nextOnStackViewController)
        } else {
            return vc
        }
    }
    
    func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {
        
        let previousViewController = rootViewController
        
        if let transition = transition {
            layer.add(transition, forKey: kCATransition)
        }
        rootViewController = newRootViewController

        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }
        
        if let transitionViewClass = NSClassFromString("UITransitionView") {
            for subview in subviews where subview.isKind(of: transitionViewClass) {
                subview.removeFromSuperview()
            }
        }
        
        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
    
}
