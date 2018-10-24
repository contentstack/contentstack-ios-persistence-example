//
//  Session.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 13/08/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit
import Realm

class Session: RLMObject, EntryProtocol {
    @objc dynamic var sessionId = 0
    
    @objc dynamic var type: String!
    
    @objc dynamic var title: String!
    
    @objc dynamic var desc: String!

    @objc dynamic var url: String!
    
    @objc dynamic var uid: String!

    @objc dynamic var publishLocale: String!

    @objc dynamic var createdAt: Date!
    
    @objc dynamic var updatedAt: Date!
    
    @objc dynamic var locale: String!
        
    @objc dynamic var isPopular = false
    
    @objc dynamic var startTime: Date!

    @objc dynamic var endTime: Date!

    static func contentTypeid() -> String! {
        return "session"
    }
    
    static func fieldMapping() -> [AnyHashable : Any]! {
        return ["sessionId":"session_id",
                "desc": "description",
                "type":"type",
                "isPopular":"is_popular",
                "startTime":"start_time",
                "endTime":"end_time"]
    }
    
    func sessionTime() -> String {
        var sessionTime = ""
        if let stime = self.startTime {
            sessionTime = self.sessionTimeFormatter().string(from: stime)
            if let eTime = self.endTime {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                sessionTime = "\(sessionTime) - \(dateFormatter.string(from: eTime))"
            }
        }
        return sessionTime
    }
    
    private func sessionTimeFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM d, h:mm a"
        return dateFormatter
    }
    
}
