//
//  SessionListWorker.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 14/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit

class SessionListWorker
{
    func perfromSessionRequest(request: SessionList.Request) -> SessionList.Response {
        return SessionList.Response(sessionArray: request.getSessions())
    }
}
