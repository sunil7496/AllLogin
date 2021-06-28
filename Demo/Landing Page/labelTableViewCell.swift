//
//  labelTableViewCell.swift
//  Demo
//
//  Created by TrivialWorks on 31/12/19.
//  Copyright © 2019 TrivialWorks. All rights reserved.
//

import UIKit

class labelTableViewCell: UITableViewCell {

    @IBOutlet weak var namelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
