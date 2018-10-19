//
//  SearchCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 17/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var compName: UILabel!
    @IBOutlet weak var searchName: UILabel!
 
    @IBOutlet weak var searchCard: UIView!
    
    func setCompany(company: Company){
        //searchName.text = tempCompany.name
        searchCard.dropShadow()
        searchCard.layer.cornerRadius = 5.0
        compName.text = company.identifiers.name
        stock.text = "Ticker "+company.identifiers.ticker
        score.text = "Score: \(company.score)"
        setScoreColor(Score: company.score)
    }
    
    func setScoreColor(Score:Int)
    {
        if (Score == 50)
        {
            score.textColor = UIColor.yellow
        }
            
        else if (Score < 50)
        {
            score.textColor =  UIColor.red
        }
            
        else{
            score.textColor =  UIColor.init(netHex: 0x1DCEB1)
            
        }
    }
    
    
    
}
