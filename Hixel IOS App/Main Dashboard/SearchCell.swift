//
//  SearchCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 17/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var searchName: UILabel!
    
    func setCompany(tempCompany: TempCompany){
        searchName.text = tempCompany.name
    }
    
    
    
}
