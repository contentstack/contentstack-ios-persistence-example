//
//  SessionDetailsRouter.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 19/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit

@objc protocol SessionDetailsRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol SessionDetailsDataPassing
{
  var dataStore: SessionDetailsDataStore? { get set }
}

class SessionDetailsRouter: NSObject, SessionDetailsRoutingLogic, SessionDetailsDataPassing
{
  weak var viewController: SessionDetailsViewController?
  var dataStore: SessionDetailsDataStore?
  
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
  
  //func navigateToSomewhere(source: SessionDetailsViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: SessionDetailsDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
