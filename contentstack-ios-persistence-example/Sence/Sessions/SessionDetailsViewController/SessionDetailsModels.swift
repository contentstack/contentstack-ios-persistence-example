//
//  SessionDetailsModels.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 19/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit

enum SessionDetails
{
  // MARK: Use cases
  
    struct Request
    {
        func fetchSession(sessionID: Int) -> Session {
            return Session.objects(with: NSPredicate(format: "sessionId = \(sessionID)")).firstObject() as! Session
        }
    }
    struct Response
    {
        var session : Session
    }
    
    struct ViewModel
    {
        struct SessionInfo {
            var isTitle: Bool
            var desc : String
        }
        
        struct SessionTimeRoom {
            var sessionTime : String?
        }
        
        struct SessionSpeakers {
            var speakers : RLMArray<Speaker>
        }
        var sessionDetailArray : [Any] = []
        
        func numberOfSection() -> Int {
            return sessionDetailArray.count
        }
        
        func numberOfRow(in section: Int) -> Int {
            if let speakerModel = sessionDetailArray[section] as? SessionSpeakers  {
                return Int(speakerModel.speakers.count)
            }
            return 1
        }
    }
}
