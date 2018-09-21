//
//  GraphInfoCollectionViewCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 22/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class GraphInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var financial_indicator: UILabel!
    @IBOutlet weak var header_info: UILabel!
    
    func setup_header_label(name : String)
    {
        financial_indicator.text = name
    }
    
    func setup_header_info(info : String)
    {
        header_info.text = info
    }
}

