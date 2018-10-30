//
//  SessionListViewController.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 14/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit
import Realm
protocol SessionListDisplayLogic: class
{
    func loadSessionList(response: SessionList.Response)
    func loadSessionDetails()
}

class SessionListViewController: UIViewController, SessionListDisplayLogic
{
    var result : RLMResults<Session>?
    
    var interactor: SessionListBusinessLogic?
    var router: (NSObjectProtocol & SessionListRoutingLogic & SessionListDataPassing)?

    @IBOutlet weak var tableView: UITableView!
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
        let interactor = SessionListInteractor()
        let presenter = SessionListPresenter()
        let router = SessionListRouter()
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
            if let rtr = router, rtr.responds(to: selector) {
                rtr.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchSession()
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 999
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(SessionCell.self)
        self.title = "SESSIONS"
    }
    
    override func updateui() {
        self.tableView.reloadData()
    }
    // MARK: Do something
        
    func fetchSession()
    {
        let request = SessionList.Request()
        interactor?.getSession(request: request)
    }
    
    func loadSessionList(response: SessionList.Response) {
        self.result = response.sessionArray
    }
    
    func loadSessionDetails() {
        //TO DO
    }
    
    deinit {
        self.cfsDeinit()
    }
}

extension SessionListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.result == nil ? 0 : Int(self.result!.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SessionCell = tableView.dequeueReusableCell(for: indexPath)
        cell.session = self.result!.object(at: UInt(indexPath.row))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        self.interactor?.showSessionDetails(self.result!.object(at: UInt(indexPath.row)).sessionId)
    }
}
