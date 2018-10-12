//
//  SearchResultTableViewCell1.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 10/10/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class SearchResultTableViewCell1: UITableViewCell {
    var exchange = ""
    var tickerSymbol = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var searchTextLabel: UILabel!
    @IBOutlet weak var ticker: UILabel!
    func setupcell(searchEntry:SearchEntry)
    {
        exchange = searchEntry.exchange
        tickerSymbol = searchEntry.ticker
        
        searchTextLabel.text = searchEntry.name
        ticker.text = exchange + " "+tickerSymbol

    }
    
}
