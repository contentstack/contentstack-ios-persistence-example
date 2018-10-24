//
//  SessionDetailsPresenter.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 19/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit

protocol SessionDetailsPresentationLogic
{
  func presentSomething(response: SessionDetails.Response)
    func loadSessionDetails(response: SessionDetails.Response)
}

class SessionDetailsPresenter: SessionDetailsPresentationLogic
{
    func loadSessionDetails(response: SessionDetails.Response) {
        var viewModel = SessionDetails.ViewModel()
        if let title = response.session.title {
            let sessioninfo = SessionDetails.ViewModel.SessionInfo(isTitle: true, desc: title)
            viewModel.sessionDetailArray.append(sessioninfo)
        }
        let sessionRoomTime = SessionDetails.ViewModel.SessionTimeRoom(sessionTime: response.session.sessionTime())
            viewModel.sessionDetailArray.append(sessionRoomTime)
        
        if let desc = response.session.desc, desc.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 {
            let sessioninfo = SessionDetails.ViewModel.SessionInfo(isTitle: false, desc: desc)
            viewModel.sessionDetailArray.append(sessioninfo)
        }
        if response.session.speaker.count > 0 {
            let sessionSpeaker = SessionDetails.ViewModel.SessionSpeakers(speakers: response.session.speaker)
            viewModel.sessionDetailArray.append(sessionSpeaker)
        }

        viewController?.displaySession(viewModel)
    }
    
  weak var viewController: SessionDetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: SessionDetails.Response)
  {
  }
}
