//
//  GraphInfoViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 22/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class GraphInfoViewController: UIViewController {
    
    let financial_indicators_name = ["Health","Safety","Performance","Returns","Strength"]
    
    let health = "Gauges a company's ability to pay short-term and long-term obligations. It's used to give an idea of a company's ability to pay back its liabilities (e.g. debt) with its assets.\n\nBased on: Current ratio = Current Assets / Current Liabilities"
    
    let safety = "Is a measure of a company's financial leverage e.g. it gauges the extent to which a company is taking on debt as a means of leveraging (attempting to increase its value by using borrowed money to fund various projects).\n\nBased on: Current Debt/Equity (D/E) Ratio = Current Liabilities / Equity"

    let strength = "Reflects how easily a company can pay interest on its outstanding debt with its available earnings. In other words, it measures the margin of safety a company has for paying interest during a given period.\n\nBased on: Interest coverage = earnings before interest and taxes (EBIT) / net interest expense"
    
    let performance = "Can also be known as profitability, it's a measure of how much profit a company generates with the money shareholders have invested. It illustrates how effective the company is at turning the cash put into the business into greater gains and growth.\n\nBased on: Return on equity (ROE) = Net Income / Shareholder's Equity"
    
    let Returns = "How much a company pays out in dividends each year relative to its share priceIt measures how much (bang for your buck) you are getting from dividends.\n\nBased on: Dividend Yield = Annual Dividends per share/Price per share"
    
    var financial_indicators_info : [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.layer.opacity = 50.0
        
        financial_indicators_info.append(health)
        financial_indicators_info.append(safety)
        financial_indicators_info.append(performance)
        financial_indicators_info.append(Returns)
        financial_indicators_info.append(strength)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    

}

extension GraphInfoViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return  financial_indicators_name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GraphInfoCollectionViewCell
        
        cell.setup_header_label(name: financial_indicators_name[indexPath.row])
        cell.setup_header_info(info: financial_indicators_info[indexPath.row])
        
        return cell
        
    }
    
}
