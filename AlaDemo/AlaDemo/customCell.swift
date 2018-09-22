//
//  customCell.swift
//  AlaDemo
//
//  Created by imac on 12/6/16.
//  Copyright © 2016 akashinfotech. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {

    @IBOutlet weak var lblDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
