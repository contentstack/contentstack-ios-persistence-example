//
//  SessionCell.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 18/09/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit

class SessionCell: UITableViewCell {

    @IBOutlet weak var sessionTitle: UILabel!
    @IBOutlet weak var sessionTime: UILabel!
    @IBOutlet weak var colorLabel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sessionTitle.font = UIFont.applicationFontSFProDisplayMedium(18)
        self.sessionTime.font = UIFont.applicationFontSFProDisplayRegular(15)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.colorLabel.backgroundColor = UIColor.clear

    }

    var session: Session? {
        didSet {
            if let sen = session {
                self.sessionTitle.text = sen.title
               self.sessionTime.text = sen.sessionTime()
            }
        }
    }
    
}
