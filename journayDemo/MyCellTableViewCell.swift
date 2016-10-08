//
//  MyCellTableViewCell.swift
//  journayDemo
//
//  Created by Wang Weihan on 3/24/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit

class MyCellTableViewCell: UITableViewCell {

    @IBOutlet weak var missionImage: UIImageView!
    
    @IBOutlet weak var imageTitle: UILabel!
    
    @IBOutlet weak var imageDescription: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
