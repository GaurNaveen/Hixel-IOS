//
//  GraphInfoCollectionViewCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 22/9/18.
//

import UIKit

class GraphInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var financial_indicator: UILabel!
    @IBOutlet weak var header_info: UILabel!
    
    /// Sets up the header label for the financial indicator.
    ///
    /// - Parameter name: Pass in the name of the financial indicator.
    func setup_header_label(name : String)
    {
        financial_indicator.text = name
    }
    
    
    /// Function sets up the header info label
    ///
    /// - Parameter info: Pass in the data you want to dosplay
    func setup_header_info(info : String)
    {
        header_info.text = info
    }
    
}

