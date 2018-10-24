//
//  SessionDetailsInteractor.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 19/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit

protocol SessionDetailsBusinessLogic
{
  func getSession(request: SessionDetails.Request)
}

protocol SessionDetailsDataStore
{
  var sessionID: Int { get set }
}

class SessionDetailsInteractor: SessionDetailsBusinessLogic, SessionDetailsDataStore
{
  var presenter: SessionDetailsPresentationLogic?
  var worker: SessionDetailsWorker?
  var sessionID: Int = 0
  
  // MARK: Do something
  
  func getSession(request: SessionDetails.Request)
  {
    worker = SessionDetailsWorker()
    let response = SessionDetails.Response(session: worker!.requestSession(request, sessionID: self.sessionID))
    presenter?.loadSessionDetails(response: response)
  }
}
