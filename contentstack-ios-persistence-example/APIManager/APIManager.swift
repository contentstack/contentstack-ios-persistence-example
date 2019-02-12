//
//  APIManager.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 13/08/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit
import Contentstack
import ContentstackPersistenceRealm

class StackConfig {
    static var APIKey           = "API_KEY"
    static var AccessToken      = "ACCESS_TOKEN"
    static var EnvironmentName  = "ENVIRONMENT"
    static var _config : Config {
        get {
            let config = Config()
            //            config.host = "URL"
            return config
        }
    }
}

enum APIManger {
    
    static var realmStore = RealmStore(realm: try? RLMRealm(configuration: RLMRealmConfiguration.default()))
    
    static var stack : Stack = Contentstack.stack(withAPIKey: StackConfig.APIKey, accessToken: StackConfig.AccessToken, environmentName: StackConfig.EnvironmentName, config:StackConfig._config)
    
    static var syncManager : SyncManager = SyncManager(stack: APIManger.stack, persistance: APIManger.realmStore!)

    static func sync () {
        self.syncManager.sync({ (percentage, isSynccompleted, error) in
            
        })
    }
}
