//
//  SessionListPresenter.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 14/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit

protocol SessionListPresentationLogic
{
    func reloadTableView(response: SessionList.Response)
  func presentSessionDetails()
}

class SessionListPresenter: SessionListPresentationLogic
{
    weak var viewController: SessionListDisplayLogic?
    
    // MARK:
    func presentSessionDetails() {
        viewController?.loadSessionDetails()
    }
    
    func reloadTableView(response: SessionList.Response) {
        viewController?.loadSessionList(response: response)
    }
}
