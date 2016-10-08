//
//  SummaryTableViewCell.swift
//  journayDemo
//
//  Created by Wang Weihan on 4/25/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var summ_Image: UIImageView!
    
    @IBOutlet weak var summ_Desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
