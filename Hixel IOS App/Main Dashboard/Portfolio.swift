//
//  Portfolio.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 7/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialSnackbar

// Global Declaration of the Array that will hold Companies Object
var companies:[TempCompany]=[]
class PortfolioController: UIViewController {

    @IBOutlet weak var verticalBarLine: UIView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var horixontalBarLine: UIView!
    @IBOutlet weak var bar1: UIView!
    @IBOutlet weak var bar2: UIView!
    @IBOutlet weak var bar3: UIView!
    @IBOutlet weak var bar4: UIView!
    @IBOutlet weak var bar5: UIView!
    @IBOutlet weak var barGraphContainerView: UIView!
    @IBOutlet weak var barGraphView: UIView!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var overallLabel: UILabel!
    
    let hardCodedStrings = ["Dashboard","Portfolio"]
    let financialIndicators = ["Health","Performance","Strength","Returns","Risk"]
    let overallFinancialValues = [3,2,5,3,4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        overallLabel.text = hardCodedStrings[1]
        
        // setup the UITable view to have a list of Companies on the Dashboard
        companies = createArray()
        setuptableView()
        
        // sets up the Graph on the Main Dashboard
        setupBarGraphView()
        
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
    
    private func setupBarGraphView()
    {
        barGraphView.dropShadow()
        barGraphView.layer.borderWidth = 1.0
        barGraphView.layer.borderColor = UIColor.init(netHex: 0x707070).cgColor
        barGraphView.layer.cornerRadius = 5.0
        
        // setup all the bars on the graph
        bar1.dropShadow()
        bar1.layer.borderColor = UIColor.black.cgColor
        bar1.layer.borderWidth = 1.0
        
        bar2.dropShadow()
        bar2.layer.borderColor = UIColor.black.cgColor
        bar2.layer.borderWidth = 1.0
        
        bar3.dropShadow()
        bar3.layer.borderColor = UIColor.black.cgColor
        bar3.layer.borderWidth = 1.0
        
        bar4.dropShadow()
        bar4.layer.borderColor = UIColor.black.cgColor
        bar4.layer.borderWidth = 1.0
        
        bar5.dropShadow()
        bar5.layer.borderColor = UIColor.black.cgColor
        bar5.layer.borderWidth = 1.0
       
        setupBarGraphLabel()
        
    }
    
    @IBOutlet weak var barLabel1: UILabel!
    @IBOutlet weak var barLabel2: UILabel!
    @IBOutlet weak var barLabel3: UILabel!
    @IBOutlet weak var barLabel4: UILabel!
    @IBOutlet weak var barLabel5: UILabel!
    
    private func setupBarGraphLabel()
    {
        barLabel1.text = financialIndicators[0]
        barLabel2.text = financialIndicators[1]
        barLabel3.text = financialIndicators[2]
        barLabel4.text = financialIndicators[3]
        barLabel5.text = financialIndicators[4]
        
        barColors()
        barLines()
    }
    
    private func barColors()
    {   bar3.translatesAutoresizingMaskIntoConstraints = false
        bar4.translatesAutoresizingMaskIntoConstraints = false
        bar5.translatesAutoresizingMaskIntoConstraints = false

        bar1.backgroundColor = calculateColor(value: overallFinancialValues[0])
        bar2.backgroundColor = calculateColor(value: overallFinancialValues[1])
        bar3.backgroundColor = calculateColor(value: overallFinancialValues[2])
        bar4.backgroundColor = calculateColor(value: overallFinancialValues[3])
        bar5.backgroundColor = calculateColor(value: overallFinancialValues[4])
        
    }
    
    // sets up the horizontal bar lines on the bar graph
    @IBOutlet weak var barHLline1: UIView!
    @IBOutlet weak var barHLine2: UIView!
    @IBOutlet weak var barHLine3: UIView!
    @IBOutlet weak var barHLine4: UIView!
    @IBOutlet weak var barHLine5: UIView!
    
    private func barLines()
    {
        barHLline1.backgroundColor = UIColor.init(netHex: 0x868686)
        barHLine2.backgroundColor = UIColor.init(netHex: 0x868686)
        barHLine3.backgroundColor = UIColor.init(netHex: 0x868686)
        barHLine4.backgroundColor = UIColor.init(netHex: 0x868686)
        barHLine5.backgroundColor = UIColor.init(netHex: 0x868686)
        
        setupBars(value: 5)
    }
    
    // Using Auto Layout to setup all the anchors for each bar. Right now the values doesn't changes dynamically but they will be added soon.
    private func setupBars(value : Int) // should take an array of int values
    {
        let oneBar = UIView()
        barGraphView.addSubview(oneBar)
        
        let secondBar = UIView()
        barGraphView.addSubview(secondBar)
        
       let barThird = UIView()
        barGraphView.addSubview(barThird)
        
        let fourthBar = UIView()
        barGraphView.addSubview(fourthBar)
        
        let fifthBar = UIView()
        barGraphView.addSubview(fifthBar)
        
        oneBar.translatesAutoresizingMaskIntoConstraints = false
        oneBar.topAnchor.constraint(equalTo: barHLine3.bottomAnchor, constant: 0).isActive = true
        oneBar.rightAnchor.constraint(equalTo: barGraphView.leftAnchor, constant: 60).isActive = true
        oneBar.bottomAnchor.constraint(equalTo: horixontalBarLine.topAnchor, constant: 0).isActive = true
        oneBar.heightAnchor.constraint(equalToConstant: 130).isActive = true
        oneBar.widthAnchor.constraint(equalToConstant: 23).isActive = true
        oneBar.backgroundColor = calculateColor(value: 3)
        oneBar.dropShadow()
        oneBar.layer.borderColor = UIColor.black.cgColor
        oneBar.layer.borderWidth = 1.5
        
        secondBar.translatesAutoresizingMaskIntoConstraints = false
        secondBar.topAnchor.constraint(equalTo: barHLine2.bottomAnchor, constant: 0).isActive = true
        secondBar.bottomAnchor.constraint(equalTo: horixontalBarLine.topAnchor, constant: 0).isActive = true
        secondBar.leftAnchor.constraint(equalTo: bar1.rightAnchor, constant: 20).isActive = true
        secondBar.rightAnchor.constraint(equalTo: barGraphView.leftAnchor, constant: 102).isActive = true
        secondBar.heightAnchor.constraint(equalToConstant: 130).isActive = true
        secondBar.widthAnchor.constraint(equalToConstant: 23).isActive = true
        secondBar.backgroundColor = calculateColor(value: 2)
        secondBar.dropShadow()
        secondBar.layer.borderColor = UIColor.black.cgColor
        secondBar.layer.borderWidth = 1.5
        
        barThird.translatesAutoresizingMaskIntoConstraints = false
        barThird.topAnchor.constraint(equalTo: barHLine4.bottomAnchor, constant: 0).isActive = true
        barThird.leftAnchor.constraint(equalTo: secondBar.rightAnchor, constant: 40).isActive = true
        barThird.rightAnchor.constraint(equalTo: barGraphView.leftAnchor, constant: 168).isActive = true
        barThird.bottomAnchor.constraint(equalTo: horixontalBarLine.topAnchor, constant: 0).isActive = true
        barThird.heightAnchor.constraint(equalToConstant: 153).isActive = true
        barThird.widthAnchor.constraint(equalToConstant: 23).isActive = true
        barThird.backgroundColor = calculateColor(value: 4)
        barThird.dropShadow()
        barThird.layer.borderColor = UIColor.black.cgColor
        barThird.layer.borderWidth = 1.5
        
        fourthBar.translatesAutoresizingMaskIntoConstraints = false
        fourthBar.topAnchor.constraint(equalTo: barHLine3.bottomAnchor, constant: 0).isActive = true
        fourthBar.bottomAnchor.constraint(equalTo: horixontalBarLine.topAnchor, constant: 0).isActive = true
        fourthBar.leftAnchor.constraint(equalTo: barThird.rightAnchor, constant: 43).isActive = true
        fourthBar.rightAnchor.constraint(equalTo: barGraphView.leftAnchor, constant: 238).isActive = true
        fourthBar.heightAnchor.constraint(equalToConstant: 118).isActive = true
        fourthBar.widthAnchor.constraint(equalToConstant: 21).isActive = true
        fourthBar.backgroundColor = calculateColor(value: 3)
        fourthBar.dropShadow()
        fourthBar.layer.borderColor = UIColor.black.cgColor
        fourthBar.layer.borderWidth = 1.5
        
        fifthBar.translatesAutoresizingMaskIntoConstraints = false
        fifthBar.topAnchor.constraint(equalTo: barHLine4.bottomAnchor, constant: 0).isActive = true
        fifthBar.bottomAnchor.constraint(equalTo: horixontalBarLine.topAnchor, constant: 0).isActive = true
        fifthBar.leftAnchor.constraint(equalTo: fourthBar.rightAnchor, constant: 115).isActive = true
        fifthBar.rightAnchor.constraint(equalTo: barGraphView.leftAnchor, constant: 315).isActive = true
        fifthBar.heightAnchor.constraint(equalToConstant: 153).isActive = true
        fifthBar.widthAnchor.constraint(equalToConstant: 28).isActive = true
        fifthBar.backgroundColor = calculateColor(value: 4)
        fifthBar.dropShadow()
        fifthBar.layer.borderColor = UIColor.black.cgColor
        fifthBar.layer.borderWidth = 1.5
        
        
        
    }
    
    // Function that calculates the color of the bars in the graph depending on the values
    private func calculateColor(value: Int) ->(UIColor)
    {
        if(value <= 2)
        {
            return UIColor.init(netHex: 0xF1949D)
        }
        
        else if(value == 3)
        {
            return UIColor.init(netHex: 0xFEF69A)
        }
        
        else
        {
            return UIColor.init(netHex: 0xD2FC9A)
        }
    
    }
    

}
// MARK: Extension Methods for UIColor and UIView
// To get Custom Colors or To convert hex code into rgba
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
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 0.5
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
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
        
        let temp_company = companies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell") as! CompanyCell
        cell.setCompany(tempCompany: temp_company)
        return cell
        }
    
    // Adds the swipe to delete to UITableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let deletedCompany = companies[0]
        if editingStyle == .delete{
            companies.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        // Displays the snackbar when a company gets deleted
        let message = MDCSnackbarMessage()
        let action = MDCSnackbarMessageAction()
        let actionHandler = { () in
            let actionMessage = MDCSnackbarMessage()
            // When the user clicks the UNDO button perform the action here
            self.insertNewRow(deletedCompany: deletedCompany)
            actionMessage.text = deletedCompany.name + " added back to portfolio"
            MDCSnackbarManager.show(actionMessage)
            
        }
        action.handler = actionHandler
        action.title = "Undo"
        message.action = action
        message.text = deletedCompany.name+" deleted from Portfolio"
        MDCSnackbarManager.show(message)
        
    }
    
    // Adds the deleted company back to the table view
    func insertNewRow(deletedCompany : TempCompany)
    {
        companies.append(deletedCompany)
        
        let indexPath = IndexPath(row: companies.count-1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        tableView.endUpdates()
    
    }
    
}

