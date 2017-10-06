//
//  TabacoCollectionViewCell.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 02/10/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class TabacoCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        super.awakeFromNib()
    }
    @IBOutlet var tabacoImage: UIImageView!
}
