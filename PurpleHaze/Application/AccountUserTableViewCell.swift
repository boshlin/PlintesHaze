//
//  AccountUserTableViewCell.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 02/10/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class AccountUserTableViewCell: UITableViewCell {

    @IBOutlet var userName: UILabel!
    @IBOutlet var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImage.layer.cornerRadius = 18
        self.userImage.clipsToBounds = true
    }
}
