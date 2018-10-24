//
//  SplashScreenPresenter.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 07/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//  
//

import UIKit

protocol SplashScreenPresentationLogic
{
    func presentMainController()
    func handleError(_ error: Error)
}

class SplashScreenPresenter: SplashScreenPresentationLogic
{
    weak var viewController: SplashScreenDisplayLogic?
    
    // MARK:
    func presentMainController() {
        let storyboard = UIStoryboard(name: "Session", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        AppDelegate.shared.window?.rootViewController = viewController
    }
    
    func handleError(_ error: Error) {
        let storyboard = UIStoryboard(name: "Session", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        AppDelegate.shared.window?.rootViewController = viewController
    }
}
