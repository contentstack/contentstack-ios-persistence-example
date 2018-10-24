//
//  UIViewController+Extension.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 07/09/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

private let swizzling: (UIViewController.Type) -> (Swift.Void) = { viewController in

    let originalSelector = #selector(viewController.viewDidLoad)
    let swizzledSelector = #selector(viewController.cfsViewDidLoad)

    let originalMethod = class_getInstanceMethod(viewController, originalSelector)
    let swizzledMethod = class_getInstanceMethod(viewController, swizzledSelector)

    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}

protocol StoryBoardID: class {}

extension StoryBoardID where Self: UIViewController {
    static var storyBoardID: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryBoardID {
    
    class func initializ() {
        guard self === UIViewController.self else { return }
        swizzling(self)
    }

    @objc func cfsViewDidLoad() {
        self.cfsViewDidLoad()
        self.updateui()
    }
    
    @objc func updateui() {
        
    }
    
    func alertUser (errorMessage: String, completion: (()->Swift.Void)? = nil) {
        let alertView = UIAlertController(title: "", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.default) { (_) in
            if let cmp = completion {
                cmp()
            }
        }
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func getViewController() -> UIViewController {
        if let presentViewcontroller = self.presentedViewController {
            return presentViewcontroller.getViewController()
        }
        return self
    }
    
    func cfsDeinit () {

    }
}

extension UINavigationController {
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.topViewController!.preferredInterfaceOrientationForPresentation
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController!.supportedInterfaceOrientations
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController!.preferredStatusBarStyle
    }
}
