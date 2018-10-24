//
//  SplashScreenInteractor.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 07/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//  
//

import UIKit

protocol SplashScreenBusinessLogic
{
    func performSync(request: SplashScreen.Sync.Request, completion: @escaping ((SplashScreen.Sync.Response)-> (Swift.Void)))
}

protocol SplashScreenDataStore
{
    //var name: String { get set }
}

class SplashScreenInteractor: SplashScreenBusinessLogic, SplashScreenDataStore
{
    var presenter: SplashScreenPresentationLogic?
    var worker: SplashScreenWorker?

    // MARK: Perform Sync
    
    func performSync(request: SplashScreen.Sync.Request, completion: @escaping ((SplashScreen.Sync.Response) -> (Void))) {
        worker = SplashScreenWorker()
        worker?.performSync(request, completion: {[weak self] (percentage, isCompleted, error) -> (Void) in
            let response = SplashScreen.Sync.Response(percentage: percentage, isCompleted: isCompleted, error: error)
            completion(response)
            guard let slf = self else {return}
            if let err = error {
                slf.presenter?.handleError(err)
            }else if response.isCompleted {
                slf.presenter?.presentMainController()
            }
        })
    }
}
