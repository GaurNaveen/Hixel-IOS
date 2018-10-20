//
//  TableViewCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 19/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ratioName: UILabel!
    @IBOutlet weak var ratioValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Function sets up the label with the ratio name.
    ///
    /// - Parameter name: Pass in the name.
    func setupLabel(name: String)
    {
        ratioName.text = name
        
    }
    
    func setupLabelValue(value: Double)
    {
        ratioValue.text = String(value)
    }
    

}
