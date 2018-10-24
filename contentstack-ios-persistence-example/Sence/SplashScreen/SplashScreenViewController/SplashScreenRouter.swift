//
//  SplashScreenRouter.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 07/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//  
//

import UIKit

@objc protocol SplashScreenRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol SplashScreenDataPassing
{
  var dataStore: SplashScreenDataStore? { get }
}

class SplashScreenRouter: NSObject, SplashScreenRoutingLogic, SplashScreenDataPassing
{
  weak var viewController: SplashScreenViewController?
  var dataStore: SplashScreenDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: SplashScreenViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: SplashScreenDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
