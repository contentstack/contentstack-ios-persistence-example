//
//  SplashScreenWorker.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 07/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//  
//

import UIKit

class SplashScreenWorker
{
    func performSync(_ request: SplashScreen.Sync.Request, completion: @escaping ((_ percentage:(Double), _ isSyncCompleted: Bool, _ error:Error?)-> (Swift.Void)))
    {
        request.sync(completion)
    }
}
