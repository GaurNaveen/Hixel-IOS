//
//  Portfolio.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 7/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import Foundation
import UIKit

// Global Declaration of the Array that will hold Companies Object
var companies:[TempCompany]=[]
class PortfolioController: UIViewController {

    @IBOutlet weak var header: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var overallLabel: UILabel!
    let hardCodedStrings = ["Dashboard","Overall"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        overallLabel.text = hardCodedStrings[1]
        
        // setup the UITable view to have a list of Companies on the Dashboard
        companies = createArray()
        setuptableView()
    }
    
    // Sets up the Header View of the Portfolio/Dashboard
    private func setupHeaderView(){
        header.backgroundColor = UIColor.init(netHex: 0x395A97)
        headerLabel.text = hardCodedStrings[0]
        headerLabel.textColor = .white
        
    }
    
    // Configures the Delegate and DataSource for the Table View
    private func setuptableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Creates a temporary array that holds the company names and then returns it
    private func createArray() ->[TempCompany]{
        var tempCompanies: [TempCompany] = []
        let company1 = TempCompany(name: "Apple Inc", stockExchange: "NASDAQ", score: "12%")
        let company2 = TempCompany(name: "Rolls Royce", stockExchange: "NASDAQ", score: "89%")
        let company3 = TempCompany(name: "BMW", stockExchange: "NYSE", score: "95%")
        let company4 = TempCompany(name: "Alphabet", stockExchange: "NYSE", score: "55%")
        let company5 = TempCompany(name: "Daimler AMG", stockExchange: "NYSE", score: "67%")
        
        
        tempCompanies.append(company1)
        tempCompanies.append(company2)
        tempCompanies.append(company3)
        tempCompanies.append(company4)
        tempCompanies.append(company5)
        return tempCompanies
    }



}
// MARK: Extension Methods for UIColor and UIView
// To get Custom Colors or To convert hex code into rgb
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

// To add shadow effects on views
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func drawLine()
    {
        
    }
}

// MARK: Table View setup here
extension PortfolioController: UITableViewDelegate,UITableViewDataSource{
    
    // Determines how many rows the table view should actually have
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    // This function is used to configure each and every cell in the Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Blocks the display of Apple Inc but that will be fixed later
        if indexPath.row == 0{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "CompanyCell2") as! Cell2
            cell2.setupLabel()
            return cell2
        }
        else{
        let temp_company = companies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell") as! CompanyCell
        
        cell.setCompany(tempCompany: temp_company)
        return cell
        }
    }
    
}

