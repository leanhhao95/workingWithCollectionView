//
//  PeopleCollectionViewCell.swift
//  MeetPeopleModel
//
//  Created by Anh Hao on 12/14/17.
//  Copyright © 2017 Anh Hao. All rights reserved.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func prepareForReuse() {
        userImage.image = nil
        nameLabel.text = ""
    }
}
