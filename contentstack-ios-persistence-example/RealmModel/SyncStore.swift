//
//  SyncStore.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 13/08/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit
import Realm
import ContentstackPersistenceRealm
class SyncStore: RLMObject, SyncStoreProtocol {
    @objc dynamic var syncToken: String!
    @objc dynamic var paginationToken: String!
}
