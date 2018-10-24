//
//  SessionDetailsWorker.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 19/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit

class SessionDetailsWorker
{
    func requestSession(_ request: SessionDetails.Request, sessionID: Int) -> Session
  {
    return request.fetchSession(sessionID: sessionID)
  }
}
