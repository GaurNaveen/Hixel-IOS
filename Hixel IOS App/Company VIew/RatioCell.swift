//
//  RatioCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 23/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class RatioCell: UICollectionViewCell {
    @IBOutlet weak var indicator: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    func setupIndicator(name : String)
    {
        cellView.layer.cornerRadius = 12.0
        cellView.layer.borderColor = UIColor.black.cgColor
        cellView.layer.borderWidth = 0.5
        indicator.text = name
    }
    
}