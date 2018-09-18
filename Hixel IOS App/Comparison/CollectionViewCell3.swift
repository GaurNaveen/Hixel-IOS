//
//  CollectionViewCell3.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 19/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class CollectionViewCell3: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    func setIndicatorsLabel(indicator: String)
    {
        label.text = indicator
    }
    
}
