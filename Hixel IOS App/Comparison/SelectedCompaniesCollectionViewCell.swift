//
//  SelectedCompaniesCollectionViewCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 28/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class SelectedCompaniesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var companyName: UILabel!
    
    func setupCell(name : String)
    {
       // view.dropShadow()
        view.layer.cornerRadius = 10.0
        companyName.text = name
        
    }
}
