//
//  GolfCourseTableViewCell.swift
//  iCaddy
//
//  Created by Kyle Summers on 4/21/20.
//  Copyright © 2020 Kyle Summers. All rights reserved.
//

import UIKit

class GolfCourseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
