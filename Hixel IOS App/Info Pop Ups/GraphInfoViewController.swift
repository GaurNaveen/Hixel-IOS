//
//  GraphInfoViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 22/9/18.
//

import UIKit
import Charts
class GraphInfoViewController: UIViewController {
    
    
    let financial_indicators_name = ["1. Health","2. Safety","3. Performance","4. Returns","5. Strength"]
    
    let health = "Gives an idea of a company's ability to pay back its liabilities (e.g. debt) with its assets.\n\nFormula: Current ratio = Current Assets / Current Liabilities"
    
    let safety = "Shows the extent to which a company is taking on debt as a means of leveraging (attempting to increase its value by using borrowed money to fund projects)\n\nFormula: Current Debt/Equity (D/E) Ratio = Current Liabilities / Equity"
    
    let strength = "Reflects how easily a company can pay interest on its outstanding debt with its available earnings.\n\nFormula: Interest Coverage = EBIT / Net Interest Expense"
    
    let performance = "A general measure of a company's profitability.\n\nFormula: Profit Margin = Net Income (Loss) / Revenues"
    
    let Returns = "Reflects the company's ability to generate profits from stockholder investments\n\nFormula: Return on Equity = Net Income (Loss) / Equity"
    
    var financial_indicators_info : [String] = []
    
    
    
    /// Function loads all the financial indicators info into an array and changes the view opacity.
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
    
    /// Action button used to dismiss the current view.
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    

}

// MARK: - Sets up the Collection view that displays the info about the financial indicators.
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
