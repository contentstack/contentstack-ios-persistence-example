//
//  SplashScreenModels.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 07/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//  
//

import UIKit

enum SplashScreen
{
  // MARK: Use cases
  
  enum Sync
  {
    struct Request
    {
        func sync(_ completion: @escaping ((_ percentage:(Double), _ isSyncCompleted: Bool, _ error:Error?)-> (Swift.Void))){
            APIManger.syncManager.sync(completion)
        }
    }
    
    struct Response
    {
        var percentage : Double
        var isCompleted : Bool
        var error: Error?
        
    }
    struct ViewModel
    {
        
    }
  }
}
