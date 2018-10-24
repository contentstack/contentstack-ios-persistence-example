//
//  APIManager.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 13/08/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit

class StackConfig {
    static var APIKey           = "***REMOVED***"
    static var AccessToken    = "***REMOVED***"
    static var EnvironmentName  = "web"
    static var _config : Config {
        get {
            let config = Config()
            config.host = "stag-cdn.contentstack.io"
            return config
        }
    }
}

enum APIManger {
    
    static var realmStore = RealmStore(realm: try? RLMRealm(configuration: RLMRealmConfiguration.default()))
    
    static var stack : Stack = Contentstack.stack(withAPIKey: StackConfig.APIKey, accessToken: StackConfig.AccessToken, environmentName: StackConfig.EnvironmentName, config:StackConfig._config)
    
    static var syncManager : SyncManager = SyncManager(stack: APIManger.stack, persistance: APIManger.realmStore!)

    static func sync () {
        self.syncManager.sync { (totalCount, loadedCount, error) in
            
        }
    }
}
