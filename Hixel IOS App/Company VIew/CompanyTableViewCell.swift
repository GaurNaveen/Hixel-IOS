//
//  CompanyTableViewCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 19/9/18.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var ratioValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var ratioName: UILabel!
    
    /// Function that is used to  set the indicator name
    ///
    /// - Parameter name: Pass in the Indicator Name.
    func setupName(name: String)
    {
        ratioName.text = name
    }
    
    /// Function that is used to set the value for the specified indiactor.
    ///
    /// - Parameter value: Indicator Value
    func setupValue(value: Double)
    {
        ratioValue.text = String(value)
    }
    
}
