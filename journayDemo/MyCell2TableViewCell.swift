//
//  MyCell2TableViewCell.swift
//  journayDemo
//
//  Created by Wang Weihan on 3/29/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit

class MyCell2TableViewCell: UITableViewCell {

    @IBOutlet weak var missionImage2: UIImageView!
    
    @IBOutlet weak var imageTitle2: UILabel!
    
    @IBOutlet weak var imageDescription2: UILabel!
    
    @IBOutlet weak var progressview: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
