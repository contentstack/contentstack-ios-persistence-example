//
//  SessionListModels.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 14/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit
import Realm
enum SessionList
{
  // MARK: Use cases
    struct Request
    {
        func getSessions() -> RLMResults<Session> {
            return Session.allObjects().sortedResults(using: [RLMSortDescriptor(keyPath: "startTime", ascending: true)]) as! RLMResults<Session>
        }
    }
    
    struct Response
    {
        var sessionArray : RLMResults<Session>
    }
    
    struct ViewModel
    {
    }
  
}
