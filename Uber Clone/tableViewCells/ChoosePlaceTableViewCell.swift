//
//  ChoosePlaceTableViewCell.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 11/03/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//

import UIKit

class ChoosePlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
