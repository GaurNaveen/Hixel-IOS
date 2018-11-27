//
//  SearchComparisonCell.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 12/10/18.
//

import UIKit

class SearchComparisonCell: UITableViewCell {

    @IBOutlet weak var ticker: UILabel!
    @IBOutlet weak var compName: UILabel!
    
    var exchange = ""
    var tickerSymbol = ""
    
    func setupCell(company:SearchEntry)
    {
        exchange = company.exchange
        tickerSymbol = company.ticker
        
        // Setup Cell Labels with the server results.
        compName.text = company.name
        ticker.text = exchange + " " + tickerSymbol
    }
}
