//
//  SessionListRouter.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 14/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit

@objc protocol SessionListRoutingLogic
{
    func routeToshowSessionDetailsWithSegue(_ segue: UIStoryboardSegue?)
}

protocol SessionListDataPassing
{
    var dataStore: SessionListDataStore? { get }
}

class SessionListRouter: NSObject, SessionListRoutingLogic, SessionListDataPassing
{
    weak var viewController: SessionListViewController?
    var dataStore: SessionListDataStore?

    func routeToshowSessionDetailsWithSegue(_ segue: UIStoryboardSegue?) {
        
    }
    
}

