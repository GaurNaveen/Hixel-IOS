//
//  Portfolio.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 7/9/18.
//

import Foundation
import UIKit
import MaterialComponents.MaterialSnackbar
import Moya
import Charts
import SVProgressHUD

/// Global Declaration of the Array that will hold companies Object
var info = false
var companies: [TempCompany] = []
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
    @IBOutlet weak var barGraphContainerView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchController: UISearchBar!
    @IBOutlet weak var verticalAxis: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var verticalBarLine: UIView!
    @IBOutlet weak var summary: UILabel!
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

        searchTableView.isHidden = true
        barChartView.noDataText = ""
        
        setupHeaderView()
        overallLabel.text = hardCodedStrings[1]
        months = ["Health", "Performance", "Return", "Safety", "Strength"]

        companies = []
        
        setuptableView()
        
        searchTableView.dropShadow()
        barChartView.dropShadow()
        barChartView.layer.shadowOpacity = 0.5
        barChartView.layer.shadowRadius = 1.5
        
        if (add == true)
        {
            companies += companyToAdd
            reload()
        }
        
    }
    
    /// Function activates when the View Appears on the Screen.
    ///
    /// - Parameter animated: Already specified for you.
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        searchTableView.isHidden = true
        searchBar.text = ""
        move = false

        if (portcomp.count > 0)
        {
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
        barChartView.legend.enabled = false
        barChartView.drawValueAboveBarEnabled = false
        barChartView.drawBarShadowEnabled = false
        var dataEntries : [BarChartDataEntry] = []
        
        for i in 0 ..< dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        
        chartDataSet.setColors(setupBarChartColors(values: values[0]),setupBarChartColors(values: values[1]),setupBarChartColors(values: values[2]),setupBarChartColors(values: values[3]),setupBarChartColors(values: values[4]))

        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.2
        chartData.setDrawValues(false)
        chartData1 = chartData
        
        //reset all the 5 colors of graph here depending upon the values
        
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
    
    func setupBarChartColors(values:Double) -> NSUIColor {
        if (values > 3)
        {
            return UIColor.init(netHex: 0x1DCEB1)
        }
        else if (values < 3)
        {
            return UIColor.init(netHex:0xFF5D84 )
        }
        else
        {
            return UIColor.init(netHex: 0xFFDD7C)
        }
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
    
    /// sets up the horizontal bar lines on the bar graph
    @IBOutlet weak var barHLline1: UIView!
    @IBOutlet weak var barHLine2: UIView!
    @IBOutlet weak var barHLine3: UIView!
    @IBOutlet weak var barHLine4: UIView!
    @IBOutlet weak var barHLine5: UIView!
    
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
    
    // Function that calculates the color of the bars in the graph depending on the values
    private func calculateColor(value: Int) ->(UIColor)
    {
        if (value <= 2)
        {
            return UIColor.init(netHex: 0xFF5D84)
        }
        else if (value == 3)
        {
            return UIColor.init(netHex: 0xFFDD7C)
        }
        else
        {
            return UIColor.init(netHex: 0x1DCEB1)
        }
        
    }
    
    /// Function that provides Bar Chart with Data.
    func dataForBarChart()
    {
        avgScores.removeAll()
        
        // For Health
        var x = 0.0
        
        for i in 0...portcomp.count-1 {
            x += portcomp[i].getHealth()
        }
        
        healthfinal = Double(Int(x)/portcomp.count)
        
        // For Return 
        var r = 0.0
        for i in 0...portcomp.count-1 {
            r += portcomp[i].getReturns()
        }
        
        returnFinal = Double(Int(r)/portcomp.count)
        
        // FOR SAFETY
        var sf = 0.0
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
    func search(query:String)
    {
        let _ = Client().request(.search(query: query)).subscribe { event in
            switch event{
            case .success(let response):
                let searches = try! JSONDecoder().decode([SearchEntry].self, from: response.data)
                self.searchArray = searches
                
                // MARK: Reload the table data when the search results are in.
                self.searchTableView.reloadData()
                var frame = self.searchTableView.frame
                frame.size.height = self.searchTableView.contentSize.height + 50
                self.searchTableView.frame = frame
                break
                
            case .error(let error):
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
                let company = try! JSONDecoder().decode([Company].self, from: response.data)

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
    
    /// Adds the company to the user portfolio.
    func addCompany(ticker: String)
    {
        let _ = Client().request(.addCompany(ticker: ticker)).subscribe { event in
            switch event {
            case .success(let response ):
                let _ = try! JSONSerialization.jsonObject(with: response.data, options: [])
                //TODO: Update the portfolio with this data.
                
            case .error(let error):
                print(error)
            }
        }
    }
    
    /// Removes a company from the user portfolio
    ///
    /// - Parameter deletedCompanyTicker: Takes the deleted company ticker
    func removeCompany(deletedCompanyTicker:String)
    {
        let _ = Client().request(.removeCompany(ticker: deletedCompanyTicker)).subscribe{
            event in
            switch event{
            case .success(let response):
                let _ = try! JSONSerialization.jsonObject(with: response.data, options: [])
                //TODO: Update the portfolio with this data.
                
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
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = false
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
        if tableView == searchTableView {
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
        
        if (tableView == self.searchTableView)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultTableViewCell1
            
            if(searchArray.count != 0 )
            {
                cell.setupcell(searchEntry: searchArray[indexPath.row])
            }
            
            return cell
        }
        else  {
            var temp_company = portcomp[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell") as! CompanyCell
            cell.setCompany(tempCompany: temp_company)
            let score = temp_company.calculateScore()
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
        
        if (editingStyle == .delete)
        {
            portcomp.remove(at: indexPath.row)
            removeCompany(deletedCompanyTicker:deletedCompany.identifiers.ticker)
            self.tableView.reloadData()
            
            if (portcomp.count > 0)
            {
                dataForBarChart()
                let yvalues = avgScores
                setupBarChart(dataPoints: months, values: yvalues)
                
            }
            
            if (portcomp.count == 0)
            {
                let yValues = [0.0,0.0,0.0,0.0,0.0]
                self.setupBarChart(dataPoints: months, values: yValues)
            }
            
            self.barChartView.invalidateIntrinsicContentSize()
        }
        
        // Displays the snackbar when a company gets deleted
        let message = MDCSnackbarMessage()
        let action = MDCSnackbarMessageAction()
        
        action.handler = {
            let actionMessage = MDCSnackbarMessage()
            
            // When the user clicks the UNDO button perform the action here
            self.insertNewRow(deletedCompany: deletedCompany,deletedIndex: deletedIndex)
            actionMessage.text = deletedCompany.identifiers.ticker + " added back to Portfolio"
            MDCSnackbarManager.show(actionMessage)
            
            self.addCompany(ticker: deletedCompany.identifiers.ticker)
            
            //---Reload the Bar Graph when a company is added back again.
            self.dataForBarChart()
            let yvalues = self.avgScores
            self.setupBarChart(dataPoints: self.months, values: yvalues)
        }
        
        action.title = "Undo"
        message.action = action
        message.text = deletedCompany.identifiers.ticker + " removed from Portfolio"
        MDCSnackbarManager.show(message)
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
        tableView.reloadData()
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
        if (tableView == self.searchTableView)
        {
            SVProgressHUD.show()
            info = false
            
            indexPath1 = indexPath
            let ticker = searchArray[indexPath.row].ticker
            
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
    
    
    /// Function is called when there is a segue going to happen
    /// between two view. It pretty much sets the data on the next view before
    /// segue has occured.
    /// - Parameters:
    ///   - segue: Defined for you.
    ///   - sender: Defined for you.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (info == false)
        {
            let vc = segue.destination as! CompanyController
            
            if (move == true)
            {
                vc.searchedCompany = loadedCompany[0]
            }
            else
            {
                vc.searchedCompany = portcomp[indexPath1.row]
            }
        }
    }
}

// MARK: - Sets up the Search Bar
extension PortfolioController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTableView.isHidden = false
        
        if (searchText.count != 0)
        {
            search(query: searchText)
        }
        
        if (searchText.count == 0)
        {
            searchTableView.isHidden  = true
        }
    }
}

