//
//  CompanyTableViewCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 19/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var ratioValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var ratioName: UILabel!
    
    func setupName(name: String)
    {
        ratioName.text = name
    }
    
    func setupValue(value: Double)
    {
        ratioValue.text = String(value)
    }
    
}
