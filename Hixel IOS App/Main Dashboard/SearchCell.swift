//
//  SearchCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 17/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    /// IBOutlets from the View
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var compName: UILabel!
    @IBOutlet weak var searchName: UILabel!
    @IBOutlet weak var searchCard: UIView!
    
    /// Function sets up the cell for a collection
    /// view that displays score for a company and
    //  the name for it.
    ///
    /// - Parameter company: Pass the Company you want to display inside the cell.
    func setCompany( company: inout Company){
        //searchName.text = tempCompany.name
        searchCard.dropShadow()
        searchCard.layer.cornerRadius = 5.0
        compName.text = company.identifiers.name
        stock.text = "Ticker "+company.identifiers.ticker
        
        score.text = "Score: \(company.calculateScore())"
        setScoreColor(Score: company.score)
    }
    
    /// Function sets the color of stroke
    /// depending upon the score value.
    ///
    /// - Parameter Score: Pass the Score for the Company.
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
