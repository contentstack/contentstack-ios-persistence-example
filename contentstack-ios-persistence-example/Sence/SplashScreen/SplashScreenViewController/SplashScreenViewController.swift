//
//  SplashScreenViewController.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 07/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//  
//

import UIKit

protocol SplashScreenDisplayLogic: class
{
    func displaySomething(viewModel: SplashScreen.Sync.ViewModel)
}

class SplashScreenViewController: UIViewController, SplashScreenDisplayLogic
{
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var progressView: UIProgressView!
    var interactor: SplashScreenBusinessLogic?
    
    var router: (NSObjectProtocol & SplashScreenRoutingLogic & SplashScreenDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = SplashScreenInteractor()
        let presenter = SplashScreenPresenter()
        let router = SplashScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.activityIndicator.color = UIColor.orange
        performSync()
    }
    
    // MARK:
    
    func performSync()
    {
        let request = SplashScreen.Sync.Request()
        interactor?.performSync(request: request, completion: {[weak self] (response) -> (Void) in
            guard let slf = self else {return}
            slf.progressView.progress = Float(response.percentage)
        })
    }
    
    func displaySomething(viewModel: SplashScreen.Sync.ViewModel)
    {
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    deinit {
        self.cfsDeinit()
    }
}

