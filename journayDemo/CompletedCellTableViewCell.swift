//
//  CompletedCellTableViewCell.swift
//  journayDemo
//
//  Created by Wang Weihan on 4/25/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit

class CompletedCellTableViewCell: UITableViewCell {

    @IBOutlet weak var completed_Image: UIImageView!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var country: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
