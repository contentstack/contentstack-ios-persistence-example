//
//  Assets.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 13/08/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit

class Assets: RLMObject, AssetProtocol, Codable {
    
    @objc dynamic var publishLocale: String!
    
    @objc dynamic var title: String!
    
    @objc dynamic var uid: String!
    
    @objc dynamic var createdAt: Date!
    
    @objc dynamic var updatedAt: Date!
        
    @objc dynamic var fileName: String!
    
    @objc dynamic var url: String!
    
}
