//
//  SessionDetailsViewController.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 19/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit

protocol SessionDetailsDisplayLogic: class
{
    func displaySession(_ viewModel: SessionDetails.ViewModel)
}

class SessionDetailsViewController: UIViewController, SessionDetailsDisplayLogic
{
   
    @IBOutlet weak var tableView: UITableView!
    var dataSource : SessionDetails.ViewModel = SessionDetails.ViewModel()
    var interactor: SessionDetailsBusinessLogic?
    var router: (NSObjectProtocol & SessionDetailsRoutingLogic & SessionDetailsDataPassing)?
    
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
        let interactor = SessionDetailsInteractor()
        let presenter = SessionDetailsPresenter()
        let router = SessionDetailsRouter()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "SESSION"
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 999
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(SessionTitleDescCell.self)
        self.tableView.registerNib(SessionTimeRoomCell.self)
        self.tableView.registerNib(SpeakerCell.self)
        if let sessionID = idForView, let intVal = Int(sessionID)
        {
            var destinationDS = router!.dataStore!
            passSpeaker(sessionID: intVal, destination: &destinationDS)
        }
        fetchSsssion()
    }
    
    override func updateui() {
        self.tableView.reloadData()
    }
    
    private func passSpeaker(sessionID: Int, destination: inout SessionDetailsDataStore) {
        destination.sessionID = sessionID
    }
    
    func fetchSsssion()
    {
        let request = SessionDetails.Request()
        interactor?.getSession(request:  request)
    }
  
    func displaySession(_ viewModel: SessionDetails.ViewModel) {
        self.dataSource = viewModel
        self.tableView.reloadData()
    }
    
    deinit {
        self.cfsDeinit()
    }
}

extension SessionDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let sessionInfo = self.dataSource.sessionDetailArray[indexPath.section] as? SessionDetails.ViewModel.SessionInfo {
            let cell : SessionTitleDescCell = tableView.dequeueReusableCell(for: indexPath)
            if sessionInfo.isTitle {
                cell.infoLabel.textColor = UIColor.black
                cell.infoLabel.font = UIFont.applicationFontSFProDisplayBold(17)
                cell.infoLabel.text = sessionInfo.desc
            }else {
                cell.infoLabel.textColor = UIColor.darkGray
                cell.infoLabel.font = UIFont.applicationFontSFProDisplayRegular(13)
                cell.infoLabel.attributedText = sessionInfo.desc.htmlToAttributedString
            }
            return cell
        }else if let sessionTR = self.dataSource.sessionDetailArray[indexPath.section] as? SessionDetails.ViewModel.SessionTimeRoom {
            let cell : SessionTimeRoomCell = tableView.dequeueReusableCell(for: indexPath)
            cell.timeLabel.text = sessionTR.sessionTime
            cell.roomInfo.text = sessionTR.room?.title
            return cell
        }else if let sessionSpeakers = self.dataSource.sessionDetailArray[indexPath.section] as? SessionDetails.ViewModel.SessionSpeakers {
            let speaker = sessionSpeakers.speakers.object(at: UInt(indexPath.row))
            let cell: SpeakerCell = tableView.dequeueReusableCell(for: indexPath)
            cell.speakerName.text = speaker.fullName
            cell.speakerJobBio.text = speaker.jobBio()
            return cell
        }
        let cell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let sessionSpeakers = self.dataSource.sessionDetailArray[section] as? SessionDetails.ViewModel.SessionSpeakers, sessionSpeakers.speakers.count > 0 {
            return 40
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let sessionSpeakers = self.dataSource.sessionDetailArray[section] as? SessionDetails.ViewModel.SessionSpeakers, sessionSpeakers.speakers.count > 0{
            let headerView : SessionDetailTableHeader = tableView.loadNib()
            headerView.headerTitle.text = sessionSpeakers.speakers.count == 1 ?  "1 Speaker" : "\(sessionSpeakers.speakers.count) Speakers"
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sessionSpeakers = self.dataSource.sessionDetailArray[indexPath.section] as? SessionDetails.ViewModel.SessionSpeakers {
            sessionSpeakers.speakers[UInt(indexPath.row)].lodadSpeakerDetails()
        }
    }
}
