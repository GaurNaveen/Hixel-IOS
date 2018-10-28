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
import Moya
import Charts
import SVProgressHUD

/// Global Declaration of the Array that will hold varpanies Object
var info = false
var companies:[TempCompany]=[]
var indexPath1 = IndexPath(row: 0, section: 0)
var add: Bool = false
var companyToAdd : [TempCompany] = []
var move = false;
var healthfinal = 0.0
var performanceFinal = 0.0
var returnFinal = 0.0
var safetyFinal = 0.0
var strengthFinal = 0.0
class PortfolioController: UIViewController {
    
    /// IBOutlets from the View that are attached on the Storyboard.
    @IBOutlet weak var graphContainerView: UIView!
    @IBOutlet weak var MAINVIEW: UIView!
    @IBOutlet weak var searchController: UISearchBar!
    @IBOutlet weak var verticalAxis: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var SearchTableView: UITableView!
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
    
    
    /// Action Button that displays Graph Info.
    ///
    /// - Parameter sender: Self, but you don't have to worry about this.
    @IBAction func moreInfoOnGraph(_ sender: Any) {
        info = true
        // performSegue(withIdentifier: "Dashboard_Graph_info", sender: self)
        performSegue(withIdentifier: "port_graphinfo2", sender: self)
    }
    @IBOutlet weak var barChartView: BarChartView!
    
    
    let hardCodedStrings = ["Dashboard","Overview"]
    let financialIndicators = ["Health","Performance","Strength","Returns","Safety"]
    let overallFinancialValues = [3,2,5,3,4]
    let graphScale = ["0","1","2","3","4","5"]
    //let comapanyDataProvider = MoyaProvider<ServerInterface>()
    
    // MARK: Array that holds the companies retrieved from the server
    var portfolioCompanies = [Company]()
    var searchArray = [SearchEntry]()
    var loadedCompany = [Company]()
    let searchcontroller1 = UISearchController(searchResultsController: nil)
    var filteredCompanies = [String]()
    var months : [String]!
    var avgScores = [Double]()
    
    /// Funtion is called when the View Loads.
    /// It is responsible for loading the Bar Graph
    /// and the table view that displays the list of
    /// companies in the portfolio.
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Kmon",userData[0].portfolio?.companies.count)
        
        SearchTableView.dropShadow()
        graphContainerView.dropShadow()
        graphContainerView.layer.shadowOpacity = 8.0
        graphContainerView.layer.shadowRadius = 1.5
        
      //  print("Lock",portcomp[0].financialDataEntries[1].ratios.keys)
        //let res = portcomp[0].calculateGenrealIndicators()
        
       // print("Lock",res)
        SearchTableView.isHidden = true
        print("Hoollla")
        print("Companies count ",portfolioCompanies)
        
        setupHeaderView()
        overallLabel.text = hardCodedStrings[1]
        months = ["Health", "Performance", "Return", "Safety", "Strength"]
        
        
//        dataForBarChart()
//        let yvalues = avgScores
//        print("Hec",yvalues)
//        setupBarChart(dataPoints: months, values: yvalues)
        
       // ------------- Uncomment above line
        
        
        
        // barChartView.dropShadow()
        // setup the UITable view to have a list of Companies on the Dashboard
        companies = createArray()
        
        // Put these two views into a if statement when a user doesn't have a company
        setuptableView()
        
        // sets up the Graph on the Main Dashboard
        setupBarGraphView()
        print("ola")
        /* Activate when doing onboarding
         // If the user doesn't have any company then display the message
         let message = UILabel()
         MAINVIEW.addSubview(message)
         message.text = "Please add a company"
         message.font = message.font.withSize(15)
         message.translatesAutoresizingMaskIntoConstraints = false
         message.centerXAnchor.constraint(equalTo: MAINVIEW.centerXAnchor).isActive = true
         message.centerYAnchor.constraint(equalTo: MAINVIEW.centerYAnchor).isActive = true
         message.heightAnchor.constraint(equalToConstant: 120).isActive = true
         message.widthAnchor.constraint(equalToConstant: 120).isActive = true
         */
        if(add == true)
        {
            // tableView.reloadData()
            //addCompany1(company: companyToAdd!)
            
            companies += companyToAdd
            print(companies)
            
            reload()
        }
        
    }
    
    
    
    /// Function activates when the View Appears on the Screen.
    ///
    /// - Parameter animated: Already specified for you.
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        SearchTableView.isHidden = true
        searchBar.text = ""
        move = false
        print("Company count ",portcomp.count)
        if(portcomp.count>0)
        {   print("Updating")
            dataForBarChart()
            let yvalues = avgScores
            setupBarChart(dataPoints: months, values: yvalues)

        }
        
    }
    
    
    // Sets up the Header View of the Portfolio/Dashboard
    
    /// Funtion sets up the header view for the MAIN Dashboard.
    private func setupHeaderView(){
        header.backgroundColor = UIColor.init(netHex: 0x0052CC)
        headerLabel.text = hardCodedStrings[0]
        headerLabel.textColor = .white
    }
    
    var chartData1 = BarChartData()
    
    /// Function sets up the Bar Chart.
    ///
    /// - Parameters:
    ///   - dataPoints: Health Indicators.
    ///   - values: Value for the Health Indicators.
    func setupBarChart(dataPoints: [String], values: [Double])
    {
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.legend.enabled = false
        barChartView.drawValueAboveBarEnabled = false
        barChartView.drawBarShadowEnabled = false
        var dataEntries : [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
            print("Hect",dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        chartDataSet.setColors(UIColor.init(netHex: 0x1DCEB1),UIColor.init(netHex:0xFF5D84 ),UIColor.init(netHex: 0xFF5D84),UIColor.init(netHex: 0x1DCEB1),UIColor.init(netHex: 0xFFDD7C))
        // var c = ChartDataEntry(x: <#T##Double#>, y: <#T##Double#>)
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.2
        chartData.setDrawValues(false)
        chartData1 = chartData
        /*
         
         reset all the 5 colors of graph here depending upon the values
         
         */
        
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.labelCount = 5
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        barChartView.xAxis.granularity = 1.0
        barChartView.leftAxis.labelPosition = .outsideChart
        barChartView.leftAxis.drawGridLinesEnabled = true
        barChartView.leftAxis.drawLabelsEnabled = true
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.leftAxis.axisMaximum = 5.0
        barChartView.leftAxis.granularity = 1.0
        barChartView.rightAxis.enabled = false
        
        
        barChartView.data = chartData
        barChartView.xAxis.labelPosition = .bottom
        barChartView.backgroundColor = UIColor.white
        //barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    /// Updates the Chart Data
    func updateChart()
    {
        chartData1.clearValues()
        
    }
    
    
    
    /// Function use to set the Data Source and Delegate for the table view.
    private func setuptableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //    func calculateFinancialIndicators()
    //    {
    //
    //    }
    
    // Creates a temporary array that holds the company names and then returns it
    
    /// Function sets up a temporary array that holds the company names and then returns it
    /// P.S.A. It's no longer in use and will be removed shortly.
    ///
    /// - Returns: temporary array
    private func createArray() ->[TempCompany]{
        var tempCompanies: [TempCompany] = []
        let company1 = TempCompany(name: "Apple Inc", stockExchange: "NASDAQ", score: 12)
        let company3 = TempCompany(name: "Twitter Inc", stockExchange: "NYSE", score: 95)
        let company4 = TempCompany(name: "Snap Inc", stockExchange: "NYSE", score: 55)
        let company5 = TempCompany(name: "Daimler AMG", stockExchange: "NYSE", score: 67)
        let company6 = TempCompany(name: "Facebook Inc", stockExchange: "NASDAQ", score: 12)
        let company7 = TempCompany(name: "Tesla, Inc.", stockExchange: "NASDAQ", score: 89)
        let company9 = TempCompany(name: "Microsoft Corp.", stockExchange: "NYSE", score: 55)
        let company12 = TempCompany(name: "Amazon Com Inc.", stockExchange: "NYSE", score: 67)
        let company13 = TempCompany(name: "Advanced Micro Devices Inc", stockExchange: "NYSE", score: 67)
        let company14 = TempCompany(name: "Intel", stockExchange: "NYSE", score: 67)
        
        
        tempCompanies.append(company1)
        tempCompanies.append(company3)
        tempCompanies.append(company4)
        tempCompanies.append(company5)
        tempCompanies.append(company6)
        tempCompanies.append(company7)
        tempCompanies.append(company9)
        tempCompanies.append(company12)
        tempCompanies.append(company13)
        tempCompanies.append(company14)
        
        return tempCompanies
    }
    
    /// Funtion use to configue the graph view.
    /// Adds shadow , roundedcorners and autolayout on the view.
    ///
    private func setupBarGraphView()
    {
        barGraphView.dropShadow()
        barGraphView.layer.borderWidth = 1.0
        barGraphView.layer.borderColor = UIColor.init(netHex: 0x707070).cgColor
        barGraphView.layer.cornerRadius = 5.0
        
        // Setup the vertical axis for the bar graph using auto layout
        verticalAxis.translatesAutoresizingMaskIntoConstraints = false
        verticalAxis.topAnchor.constraint(equalTo: overallLabel.bottomAnchor, constant: 50).isActive = true
        verticalAxis.bottomAnchor.constraint(equalTo: barGraphView.topAnchor, constant: 5).isActive = true
        verticalAxis.leftAnchor.constraint(equalTo: barGraphView.rightAnchor, constant: 55).isActive = true
        verticalAxis.rightAnchor.constraint(equalTo: barGraphView.leftAnchor, constant: 25).isActive = true
        verticalAxis.heightAnchor.constraint(equalToConstant: 200).isActive = true
        verticalAxis.widthAnchor.constraint(equalToConstant: 2).isActive = true
        verticalAxis.backgroundColor = UIColor.black
        
        setupBarGraphLabel()
        
    }
    
    /// IBOUtlets from the main view.
    @IBOutlet weak var barLabel1: UILabel!
    @IBOutlet weak var barLabel2: UILabel!
    @IBOutlet weak var barLabel3: UILabel!
    @IBOutlet weak var barLabel4: UILabel!
    @IBOutlet weak var barLabel5: UILabel!
    
    /// FUntion use to setup graph labels.
    /// P.S. This is no longer in use.
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
    
    /// P.S. Thsi is no longer in use.
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
    
    /// sets up the horizontal bar lines on the bar graph
    @IBOutlet weak var barHLline1: UIView!
    @IBOutlet weak var barHLine2: UIView!
    @IBOutlet weak var barHLine3: UIView!
    @IBOutlet weak var barHLine4: UIView!
    @IBOutlet weak var barHLine5: UIView!
    
    /// Sets up the axis line colors.
    private func barLines()
    {
        barHLline1.backgroundColor = UIColor.init(netHex: 0x868686)
        barHLine2.backgroundColor = UIColor.init(netHex: 0x868686)
        barHLine3.backgroundColor = UIColor.init(netHex: 0x868686)
        barHLine4.backgroundColor = UIColor.init(netHex: 0x868686)
        barHLine5.backgroundColor = UIColor.init(netHex: 0x868686)
        
        setupBars(value: 5)
        setupGraphScale()
    }
    
    /// OUtlets from the sub view.
    @IBOutlet weak var scale1: UILabel!
    @IBOutlet weak var scale2: UILabel!
    @IBOutlet weak var scale3: UILabel!
    @IBOutlet weak var scale4: UILabel!
    @IBOutlet weak var scale5: UILabel!
    @IBOutlet weak var scale6: UILabel!
    private func setupGraphScale()
    {
        // Have to set them up one by one. Will be grouped together later
        scale1.text = graphScale[0]
        scale2.text = graphScale[1]
        scale3.text = graphScale[2]
        scale4.text = graphScale[5]
        scale5.text = graphScale[4]
        scale6.text = graphScale[3]
        
    }
    
    // Using Auto Layout to setup all the anchors for each bar. Right now the values doesn't changes dynamically but they will be added soon.
    let oneBar = UIView()
    let secondBar = UIView()
    let barThird = UIView()
    let fourthBar = UIView()
    let fifthBar = UIView()
    
    
    /// Function that adds the graph bar to the conatiner subview.
    private func setupBars(value : Int) // should take an array of int values
    {
        barGraphView.addSubview(oneBar)
        barGraphView.addSubview(secondBar)
        barGraphView.addSubview(barThird)
        barGraphView.addSubview(fourthBar)
        barGraphView.addSubview(fifthBar)
        
        // MARK: Setup Bars
        Setup_First_Bar(oneBar: oneBar)
        Setup_Second_Bar(secondBar: secondBar)
        Setup_Third_Bar(barThird: barThird)
        Setup_Fourth_Bar(fourthBar: fourthBar)
        Setup_Fifth_Bar(fifthBar: fifthBar)
    }
    
    /// Adds the autlayout constraints on the graph.
    ///
    /// - Parameter oneBar: graph bar
    func Setup_First_Bar(oneBar : UIView)
    {
        oneBar.translatesAutoresizingMaskIntoConstraints = false
        oneBar.topAnchor.constraint(equalTo: barHLine3.bottomAnchor, constant: 0).isActive = true
        oneBar.rightAnchor.constraint(equalTo: barGraphView.leftAnchor, constant: 60).isActive = true
        oneBar.bottomAnchor.constraint(equalTo: horixontalBarLine.topAnchor, constant: 0).isActive = true
        oneBar.heightAnchor.constraint(equalToConstant: 130).isActive = true
        oneBar.widthAnchor.constraint(equalToConstant: 23).isActive = true
        oneBar.backgroundColor = calculateColor(value: 3)
        // oneBar.dropShadow()
        oneBar.layer.borderColor = UIColor.black.cgColor
        oneBar.layer.borderWidth = 0.5
        oneBar.layer.cornerRadius = 5
    }
    
    /// Adds the autlayout constraints on the graph.
    ///
    /// - Parameter oneBar: graph bar
    func Setup_Second_Bar(secondBar: UIView)
    {
        secondBar.translatesAutoresizingMaskIntoConstraints = false
        secondBar.topAnchor.constraint(equalTo: barHLine2.bottomAnchor, constant: 0).isActive = true
        secondBar.bottomAnchor.constraint(equalTo: horixontalBarLine.topAnchor, constant: 0).isActive = true
        secondBar.leftAnchor.constraint(equalTo: bar1.rightAnchor, constant: 20).isActive = true
        secondBar.rightAnchor.constraint(equalTo: barGraphView.leftAnchor, constant: 102).isActive = true
        secondBar.heightAnchor.constraint(equalToConstant: 130).isActive = true
        secondBar.widthAnchor.constraint(equalToConstant: 23).isActive = true
        secondBar.backgroundColor = calculateColor(value: 2)
        // secondBar.dropShadow()
        secondBar.layer.borderColor = UIColor.black.cgColor
        secondBar.layer.borderWidth = 0.5
        secondBar.layer.cornerRadius = 5
    }
    
    /// Adds the autlayout constraints on the graph.
    ///
    /// - Parameter oneBar: graph bar
    func Setup_Third_Bar(barThird : UIView)
    {
        barThird.translatesAutoresizingMaskIntoConstraints = false
        barThird.topAnchor.constraint(equalTo: barHLine4.bottomAnchor, constant: 0).isActive = true
        barThird.leftAnchor.constraint(equalTo: secondBar.rightAnchor, constant: 40).isActive = true
        barThird.rightAnchor.constraint(equalTo: barGraphView.leftAnchor, constant: 168).isActive = true
        barThird.bottomAnchor.constraint(equalTo: horixontalBarLine.topAnchor, constant: 0).isActive = true
        barThird.heightAnchor.constraint(equalToConstant: 153).isActive = true
        barThird.widthAnchor.constraint(equalToConstant: 23).isActive = true
        barThird.backgroundColor = calculateColor(value: 4)
        //   barThird.dropShadow()
        barThird.layer.borderColor = UIColor.black.cgColor
        barThird.layer.borderWidth = 0.5
        barThird.layer.cornerRadius = 5
    }
    
    /// Adds the autlayout constraints on the graph.
    ///
    /// - Parameter oneBar: graph bar
    func Setup_Fourth_Bar(fourthBar : UIView)
    {
        fourthBar.translatesAutoresizingMaskIntoConstraints = false
        fourthBar.topAnchor.constraint(equalTo: barHLine3.bottomAnchor, constant: 0).isActive = true
        fourthBar.bottomAnchor.constraint(equalTo: horixontalBarLine.topAnchor, constant: 0).isActive = true
        fourthBar.leftAnchor.constraint(equalTo: barThird.rightAnchor, constant: 43).isActive = true
        fourthBar.rightAnchor.constraint(equalTo: barGraphView.leftAnchor, constant: 238).isActive = true
        fourthBar.heightAnchor.constraint(equalToConstant: 118).isActive = true
        fourthBar.widthAnchor.constraint(equalToConstant: 21).isActive = true
        fourthBar.backgroundColor = calculateColor(value: 3)
        // fourthBar.dropShadow()
        fourthBar.layer.borderColor = UIColor.black.cgColor
        fourthBar.layer.borderWidth = 0.5
        fourthBar.layer.cornerRadius = 5
    }
    
    /// Adds the autlayout constraints on the graph.
    ///
    /// - Parameter oneBar: graph bar
    func Setup_Fifth_Bar(fifthBar : UIView)
    {
        fifthBar.translatesAutoresizingMaskIntoConstraints = false
        fifthBar.topAnchor.constraint(equalTo: barHLine4.bottomAnchor, constant: 0).isActive = true
        fifthBar.bottomAnchor.constraint(equalTo: horixontalBarLine.topAnchor, constant: 0).isActive = true
        fifthBar.leftAnchor.constraint(equalTo: fourthBar.rightAnchor, constant: 115).isActive = true
        fifthBar.rightAnchor.constraint(equalTo: barGraphView.leftAnchor, constant: 315).isActive = true
        fifthBar.heightAnchor.constraint(equalToConstant: 153).isActive = true
        fifthBar.widthAnchor.constraint(equalToConstant: 28).isActive = true
        fifthBar.backgroundColor = calculateColor(value: 4)
        //  fifthBar.dropShadow()
        fifthBar.layer.borderColor = UIColor.black.cgColor
        fifthBar.layer.borderWidth = 0.5
        fifthBar.layer.cornerRadius = 5
    }
    
    // Function that calculates the color of the bars in the graph depending on the values
    private func calculateColor(value: Int) ->(UIColor)
    {
        if(value <= 2)
        {
            return UIColor.init(netHex: 0xFF5D84)
        }
            
        else if(value == 3)
        {
            return UIColor.init(netHex: 0xFFDD7C)
        }
            
        else
        {
            return UIColor.init(netHex: 0x1DCEB1)
        }
        
    }
    
    /// P.S. No longer in use.
    ///
    /// - Parameter company: <#company description#>
    func addCompany1(company : TempCompany)
    {
        //setuptableView()
        print("yewq")
        companies.append(company)
    }
    
    /// Funtion that provides Bar Chart with Data.
    func dataForBarChart()
    {
        avgScores.removeAll()
        // For Health
        var x=0.0
        for i in 0...portcomp.count-1 {
            print("Count ", i)
            x += portcomp[i].getHealth()
        }
        
        healthfinal = Double(Int(x)/portcomp.count)
        // For Return 
        var r=0.0
        for i in 0...portcomp.count-1 {
            r += portcomp[i].getReturns()
        }
        returnFinal = Double(Int(r)/portcomp.count)
        
        // FOR SAFETY
        var sf=0.0
        for i in 0...portcomp.count-1 {
            sf += portcomp[i].getSafety()
        }
        
        safetyFinal = Double(Int(sf)/portcomp.count)
        
        //FOR PERFORMANCE
        var p = 0.0
        for i in 0...portcomp.count-1 {
            p += portcomp[i].getPerformance()
        }
        performanceFinal = Double(Int(p)/portcomp.count)
        
        // For Strength
        var st = 0.0
        for i in 0...portcomp.count-1 {
            st += portcomp[i].getStrength()
        }
        strengthFinal = Double(Int(st)/portcomp.count)
        
        avgScores.append(Double(Int(x)/portcomp.count))
        avgScores.append(Double(Int(p)/portcomp.count))
        avgScores.append(Double(Int(r)/portcomp.count))
        avgScores.append(Double(Int(sf)/portcomp.count))
        avgScores.append(Double(Int(st)/portcomp.count))
    }
    
    
    
    
    // This function connects to the server and loads the search results.
    
    /// Function that connects to the server that
    /// gets the search result.
    /// - Parameter query: text entered by the user in the search bar.
    func serach(query:String)
    {
        let _ = Client().request(.search(query: query)).subscribe { event in
            switch event{
            case .success(let response):
                print("Hurray")
                
                let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
                let searches = try! JSONDecoder().decode([SearchEntry].self, from: response.data)
                self.searchArray = searches
                print("Sex",searches)
                
                // MARK: Reload the table data when the search results are in.
                self.SearchTableView.reloadData()
                var frame = self.SearchTableView.frame
                frame.size.height = self.SearchTableView.contentSize.height+50
                self.SearchTableView.frame = frame
                break
                
            case .error(let error):
                print("Yikes")
                print(error)
                break
            }
        }
    }
    
    
    /// Function that is used to load a particular company
    /// when a user selects a company from the search results.
    ///
    /// - Parameter ticker: ticker for the comapny , obtained from the search results.
    func loadCompany(ticker:String)
    {
        let _ = Client().request(.companydata(tickers: ticker, years: 5)).subscribe{ event in
            switch event {
            case .success(let response):
                // Dismiss the Progress bar.
                //SVProgressHUD.dismiss()
                
                print("hello")
                print("The ticker is",ticker)
                
                let company = try! JSONDecoder().decode([Company].self, from: response.data)
                //self.companies1[0].identifiers.name
                // self.loadedCompany = company
                self.loadedCompany = company
                SVProgressHUD.dismiss()
                move = true
                self.performSegue(withIdentifier: "Dashboard_Company", sender: self)
                
                break
                
            case .error(let error):
                print(error)
                break
            }
        }
        
    }
    
    /// Adds a company to the user portfolio
    ///
    /// - Parameter deletedCompanyTicker: Takes the deleted company ticker
    func removeCompany(deletedCompanyTicker:String)
    {
        let _ = Client().request(.removeCompany(ticker: deletedCompanyTicker)).subscribe{
            event in
            switch event{
            case .success(let response):
                let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
                print("Yass3",json)
                //self.loadUserData()
                
            case .error(let error):
                print(error)
                
            }
        }
    }
}



// MARK: - Extension Methods for UIColor and UIView
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

// MARK: - Extenison for a UI VIew that allows us to add shadow effect to it.
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


// MARK: - Table View setup here
extension PortfolioController: UITableViewDelegate,UITableViewDataSource{
    
    // Determines how many rows the table view should actually have
    
    /// Funtion that determines how many rows there will be in
    /// a table voew.
    ///
    /// - Parameters:
    ///   - tableView: Pass the table view.
    ///   - section: Pass the Section if any.
    /// - Returns: The count of how many rows there should be in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Fo the Search Results
        if tableView == SearchTableView {
            return searchArray.count
        }
        
        return portcomp.count
    }
    
    
    
    /// Function is used to configure each and every cell in the Table View.
    ///
    /// - Parameters:
    ///   - tableView: Pass the table view you want to set up.
    ///   - indexPath: Index path points to each row.
    /// - Returns: Cell configured for each index path.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView == self.SearchTableView)
        {   print("Habbib naveen")
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultTableViewCell1
            
            if(searchArray.count != 0 )
            {
                cell.setupcell(searchEntry: searchArray[indexPath.row])
                print("Hello")
            }
            
            return cell
        }
            
            
            
        else  {
            var temp_company = portcomp[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell") as! CompanyCell
            cell.setCompany(tempCompany: temp_company)
            var score = temp_company.calculateScore()
            cell.setupScore(value: score) // need to add score to the Company Class
            return cell
        }
        
    }
    
    // Adds the swipe to delete to UITableView
    /// Function enables swipe to delete.
    ///
    /// - Parameters:
    ///   - tableView: Pass the table view
    ///   - editingStyle: Pass the editing style
    ///   - indexPath: Pass the index path of the row you want to delte.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let deletedCompany = portcomp[indexPath.row]
        let deletedIndex = indexPath.row
        if editingStyle == .delete{
            portcomp.remove(at: indexPath.row)
            removeCompany(deletedCompanyTicker:deletedCompany.identifiers.ticker)
            self.tableView.reloadData()
            
            if(portcomp.count>0)
            {   print("Updating")
                dataForBarChart()
                let yvalues = avgScores
                setupBarChart(dataPoints: months, values: yvalues)
                
            }
            
            
            if(portcomp.count == 0){
                let yValues = [0.0,0.0,0.0,0.0,0.0]
                self.setupBarChart(dataPoints: months, values: yValues)

            }
            self.barChartView.invalidateIntrinsicContentSize()
        
        }
        // Displays the snackbar when a company gets deleted
        let message = MDCSnackbarMessage()
        let action = MDCSnackbarMessageAction()
        let actionHandler = { () in
            let actionMessage = MDCSnackbarMessage()
            // When the user clicks the UNDO button perform the action here
            self.insertNewRow(deletedCompany: deletedCompany,deletedIndex: deletedIndex)
            actionMessage.text = deletedCompany.identifiers.name + " added back to portfolio"
            MDCSnackbarManager.show(actionMessage)
            //---Reload the Bar Graph when a company is added back again.
            self.dataForBarChart()
            let yvalues = self.avgScores
            self.setupBarChart(dataPoints: self.months, values: yvalues)
            
        }
        action.handler = actionHandler
        action.title = "Undo"
        message.action = action
        message.text = deletedCompany.identifiers.name+" deleted from Portfolio"
        MDCSnackbarManager.show(message)
        
        // Refresh the bar graph when the user deletes a company from the portfolio
        /*
         barThird.backgroundColor = UIColor.black
         print("hello")
         */
    }
    
    // Adds the deleted company back to the table view
    /// Funtion that allows user to undo the delete option.
    ///
    /// - Parameters:
    ///   - deletedCompany: Pass the company that was delted.
    ///   - deletedIndex: Pass the deleted index.
    func insertNewRow(deletedCompany : Company,deletedIndex: Int)
    {
        portcomp.append(deletedCompany)
        
        let indexPath = IndexPath(row: deletedIndex-1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        tableView.endUpdates()
        
    }
    
    
    /// Funtion reloads the table view.
    func reload()
    {
        tableView.reloadData()
    }
    
    /// Funtion that defines the behaviour of the table view
    /// when the user taps on a row of the table view.
    /// - Parameters:
    ///   - tableView: Pass the table view.
    ///   - indexPath: Pass the index path for the selected row.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Load the company data for that particular company
        if(tableView == self.SearchTableView)
        {
            SVProgressHUD.show()
            info = false
            
            indexPath1 = indexPath
            var ticker = searchArray[indexPath.row].ticker
            
            //loadCompany(ticker)
            loadCompany(ticker: ticker)
            
            // After the company is loaded, BOOM!! move to the Company Data View
            info = false
            
            //performSegue(withIdentifier: "Dashboard_Company", sender: self)
            
        }
            
        else
        {
            info = false
            indexPath1 = indexPath
            performSegue(withIdentifier: "Dashboard_Company", sender: self)
        }
    }
    
    
    /// Function is called when there is a segue gooing to happen
    /// between two view. It pretty much sets the data on the next view before
    /// segue has occured.
    /// - Parameters:
    ///   - segue: Defined for you.
    ///   - sender: Defined for you.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if( info == false)
        {
            let vc = segue.destination as! CompanyController
            // vc.company = companies[indexPath1.row]
        
           // vc.searchedCompany = portcomp[indexPath1.row]
            
            if(move==true)
            {
                vc.searchedCompany = loadedCompany[0]
            }
            // print(vc.company)
            else{
                vc.searchedCompany = portcomp[indexPath1.row]
            }
            
        }
    }
    
    
    
    
}

// MARK: - Sets up the Search Bar
extension PortfolioController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SearchTableView.isHidden = false
        
        if(searchText.count != 0)
        {
            serach(query: searchText)
            
        }
        
        if(searchText.count == 0)
        {
            SearchTableView.isHidden  = true
        }
    }
}

