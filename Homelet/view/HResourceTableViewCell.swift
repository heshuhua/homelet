//
//  HResourceTableViewCell.swift
//  Homelet
//
//  Created by heshuhua on 2018/2/8.
//  Copyright © 2018年 heshuhua. All rights reserved.
//

import UIKit

class HResourceTableViewCell: UITableViewCell {

    @IBOutlet weak var resourceName: UILabel!
    @IBOutlet weak var resourceType: UILabel!
    @IBOutlet weak var resourceLocation: UILabel!
    
    @IBOutlet weak var resourcePhone: UILabel!
    @IBOutlet weak var resourceRemark: UILabel!
    
    @IBOutlet weak var resourceImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
