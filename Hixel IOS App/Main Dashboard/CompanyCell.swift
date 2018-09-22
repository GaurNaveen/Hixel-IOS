//
//  CompanyCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 8/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//  All the Logic for Company Cell is contained in this file

import UIKit

class CompanyCell: UITableViewCell {

    @IBOutlet weak var cv: UIView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var score: UILabel!
    
   
    func setCompany(tempCompany: TempCompany){
        companyName.text = tempCompany.name
        stock.text = "Stock: "+tempCompany.stockExchange
        containerLayouSetup()
    }
    
    // Adds shadow effect , border and increases the corner radius of the view
    func containerLayouSetup(){
        cv.dropShadow()
        cv.layer.borderWidth = 0.5
        cv.layer.cornerRadius = 6.0
    }
    
    func setupScore(value : Int)
    {
        score.text = "Score : " + String(value)
        score.textColor = calculateScoreColor(value: value)
    }
    
    // MARK: Score color calculator
    
    func calculateScoreColor(value : Int) -> UIColor
    {
        if (value == 50)
        {
            return UIColor.yellow
        }
            
        else if (value < 50)
        {
            return UIColor.red
        }
            
        else{
            return UIColor.init(netHex: 0x1DCEB1)
            
        }
    }
    

}
