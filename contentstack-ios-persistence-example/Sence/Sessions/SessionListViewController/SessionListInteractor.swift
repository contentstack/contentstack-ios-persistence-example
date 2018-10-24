//
//  SessionListInteractor.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 14/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit

protocol SessionListBusinessLogic
{
  func getSession(request: SessionList.Request)
    func showSessionDetails(_ sessionID: Int)
}

protocol SessionListDataStore
{
    var sessionID: Int {get}
}

class SessionListInteractor: SessionListBusinessLogic, SessionListDataStore
{
    var sessionID: Int = 0
    
    var presenter: SessionListPresentationLogic?
    var worker: SessionListWorker?
    
    // MARK: Do something
    func getSession(request: SessionList.Request) {
        worker = SessionListWorker()
        let response = worker?.perfromSessionRequest(request: request)
        presenter?.reloadTableView(response: response!)
    }
    
    func showSessionDetails(_ sessionID: Int) {
        self.sessionID = sessionID
        presenter?.presentSessionDetails()
    }
}
