//
//  CompanyCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 8/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//  All the Logic for Company Cell is contained in this file

import UIKit

class CompanyCell: UITableViewCell {

    /// IBOutlets from the Storyboard.
    @IBOutlet weak var cv: UIView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var score: UILabel!
    
   
    /// Funtion that displays company info
    /// for a particular cell.
    ///
    /// - Parameter tempCompany: Pass the company object you want to display.
    func setCompany(tempCompany: Company){
        companyName.text = tempCompany.identifiers.name
        stock.text = "Ticker: "+tempCompany.identifiers.ticker
        containerLayouSetup()
    }
    
    
    /// Funtion adds shadow effect , border and increases the corner radius of the view
    func containerLayouSetup(){
        cv.dropShadow()
        cv.layer.borderWidth = 0.5
        cv.layer.cornerRadius = 6.0
    }
    
    /// Funtion helps the display the
    /// Score for a company in a cell.
    ///
    /// - Parameter value: Pass the Score for a particular company.
    func setupScore(value : Int)
    {
        score.text = "Score : " + String(value)
        score.textColor = calculateScoreColor(value: value)
    }
    
    // MARK: Score color calculator
    
    /// Function that calculates the Stroke color
    /// depending upon the Score value.
    ///
    /// - Parameter value: Pass the Score Value
    /// - Returns: UI Color based on the Score Value.
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
