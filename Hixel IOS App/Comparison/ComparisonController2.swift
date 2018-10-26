//
//  ComparisonController2.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 18/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit
import Charts
class ComparisonController2: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    /// var selectedCompanies = ["Apple Inc","Samsung Corp","Alphabet","Bmw","Facebook"]
    @IBOutlet weak var lineChartView: LineChartView!
    ///  @IBOutlet weak var radarChartView: RadarChartView!
    @IBOutlet weak var radarChartView: RadarChartView!
    @IBOutlet weak var collectionView3: UICollectionView!
    /// Arrays that holds the Financial Indicators values
    var financialIndicatorsValue = [4,3,2]
    var financialIndicators = ["Financial Indicators","Health","Performance","Strength","Safety","Return"]
    var ratios = ["Liquidity Ratio","Debt Ratio","P/E Ratio"]
    let subjects = ["Health", "Safety", "Performance", "Revenue", "Strength"]
    var ratiosValue = [0,1.2,1.3,0.5,0,1.45,0.29,0.45,0,1.34,1.67,0.6]
    
    @IBAction func info(_ sender: Any) {
        // performSegue(withIdentifier: "comparison_info", sender: self) port_graphinfo2
        performSegue(withIdentifier: "comparison_graph2", sender: self)
    }
    ///Points
    var array = [1.0, 2.0, 3.0, 4.0, 5.0]
    
    var array2 = [5.0, 6.0, 2.0, 1.0, 5.0]
    @IBOutlet weak var graphContainerView: UIView!
    @IBOutlet weak var graphHeaderView: UIView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    // Contains all the companies user have selected
    var Aselected: [TempCompany] = []
    var companiesSelected : [SearchEntry] = []
    let shapeLayer = CAShapeLayer()
    var Aselected1: [Company] = []
    @IBOutlet weak var horizontalLine: UIView!
    
    /// Function sets up the graph views and their containers.
    override func viewDidLoad() {
        setStatusStatusBarColor()
        super.viewDidLoad()
        print("klopp",Aselected1)
        graphHeaderView.dropShadow()
        graphContainerView.dropShadow()
       // graphContainerView.layer.borderColor = UIColor.black.cgColor
       // graphContainerView.layer.borderWidth = 0.4
        
        // Do any additional setup after loading the view.
        array.removeAll()
        //  array.append(Int((Aselected1[0].getHealth())))
        array.append((Aselected1[0].getHealth()))
        array.append(Aselected1[0].getSafety())
        array.append(Aselected1[0].getPerformance())
        array.append(Aselected1[0].getReturns())
        array.append(Aselected1[0].getStrength())
        
        array2.removeAll()
        array2.append((Aselected1[1].getHealth()))
        array2.append(Aselected1[1].getSafety())
        array2.append(Aselected1[1].getPerformance())
        array2.append(Aselected1[1].getReturns())
        array2.append(Aselected1[1].getStrength())
        
        setupLineChart()
        setUpRadarChart(dataPoints: subjects, values: array, values2: array2)
    }
    
    func setStatusStatusBarColor()
    {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = UIColor.init(netHex: 0x1956CC)
    }
    
    // MARK: Setup Line Chart
    func setupLineChart()
    {
        var lineChartEntry = [ChartDataEntry]()
        var lineChartEntry2 = [ChartDataEntry]()
        var score_Values = [1,3,2,4,3]
        var score_Values1 = [2,1,5,1,2]
        score_Values.removeAll()
        score_Values.append(Int(Aselected1[0].getHealth()))
        score_Values.append(Int(Aselected1[0].getHealth2()))
        score_Values.append(Int(Aselected1[0].getHealth3()))
        score_Values.append(Int(Aselected1[0].getHealth4()))
        score_Values.append(Int(Aselected1[0].getHealth5()))
        
        score_Values1.removeAll()
        score_Values1.append(Int(Aselected1[1].getHealth()))
        score_Values1.append(Int(Aselected1[1].getHealth2()))
        score_Values1.append(Int(Aselected1[1].getHealth3()))
        score_Values1.append(Int(Aselected1[1].getHealth4()))
        score_Values1.append(Int(Aselected1[1].getHealth5()))
        
        let years = ["2014","2015","2016","2017","2018"]
        
        for i in 0..<score_Values.count {
            let value = ChartDataEntry(x: Double(i), y: Double(score_Values[i]))
            lineChartEntry.append(value)
        }
        
        for i in 0..<score_Values1.count {
            let value = ChartDataEntry(x: Double(i), y: Double(score_Values1[i]))
            lineChartEntry2.append(value)
        }
        let set1 = LineChartDataSet(values: lineChartEntry, label: Aselected1[0].identifiers.name)
        let set2 = LineChartDataSet(values: lineChartEntry2, label: Aselected1[1].identifiers.name)
        
        set1.circleColors = [NSUIColor.init(red: 42, green: 76, blue: 126)]
        set1.colors = [NSUIColor.init(red: 42, green: 76, blue: 126)]
        set1.mode = .cubicBezier
        set1.circleRadius  = 4.0
        
        set2.mode = .cubicBezier
        set2.circleRadius  = 4.0
        
        // Add data to the chart
        let data = LineChartData(dataSet: set1)
        data.addDataSet(set2)
        lineChartView.data = data
        lineChartView.chartDescription?.text = "Financial Indiacators"
        
        // Sets up the X axis
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter.init(values: years)
        lineChartView.xAxis.granularity = 1
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
    }
    
    func setupLineChart2(score_Values: [Int],score_Values1 : [Int])
    {
        var lineChartEntry = [ChartDataEntry]()
        var lineChartEntry2 = [ChartDataEntry]()
        
        
        let years = ["2014","2015","2016","2017","2018"]
        
        for i in 0..<score_Values.count {
            let value = ChartDataEntry(x: Double(i), y: Double(score_Values[i]))
            lineChartEntry.append(value)
        }
        
        for i in 0..<score_Values1.count {
            let value = ChartDataEntry(x: Double(i), y: Double(score_Values1[i]))
            lineChartEntry2.append(value)
        }
        let set1 = LineChartDataSet(values: lineChartEntry, label: Aselected1[0].identifiers.name)
        let set2 = LineChartDataSet(values: lineChartEntry2, label: Aselected1[1].identifiers.name)
        
        set1.circleColors = [NSUIColor.init(red: 42, green: 76, blue: 126)]
        set1.colors = [NSUIColor.init(red: 42, green: 76, blue: 126)]
        set1.mode = .cubicBezier
        set1.circleRadius  = 4.0
        
        set2.mode = .cubicBezier
        set2.circleRadius  = 4.0
        
        // Add data to the chart
        let data = LineChartData(dataSet: set1)
        data.addDataSet(set2)
        lineChartView.data = data
        lineChartView.chartDescription?.text = "Financial Indiacators"
        
        // Sets up the X axis
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter.init(values: years)
        lineChartView.xAxis.granularity = 1
        
    }
    // MARK: - Setup Radar chart
    /// Function use to setup the radar chart.
    ///
    /// - Parameters:
    ///   - dataPoints: Pass in the data points.
    ///   - values: Pass the values for company 1
    ///   - values2: Pass the values for other companies.
    func setUpRadarChart(dataPoints: [String],values: [Double],values2: [Double])
    {
        radarChartView.noDataText = "You need to provide data for the chart eh!"
        var dataEntries: [ChartDataEntry] = []
        
        // For first company
        for i in 0..<dataPoints.count {
            
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            // print(values[i])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = RadarChartDataSet(values: dataEntries, label: Aselected1[0].identifiers.name)
        
        // For Second Company
        var dataEntries2:[ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            
            let dataEntry = ChartDataEntry(x: Double(i), y: values2[i])
            // print(values[i])
            dataEntries2.append(dataEntry)
        }
        let chartDataSet2 = RadarChartDataSet(values: dataEntries2, label: Aselected1[1].identifiers.name)
        //Fills the color
        chartDataSet.fillColor = UIColor.red
        chartDataSet.setColor(UIColor.init(netHex: 0xE50D5C)) // to set the color for legend form
        radarChartView.sizeToFit()
        radarChartView.yAxis.labelCount = 6
        radarChartView.rotationEnabled = false
        chartDataSet.drawFilledEnabled = true
        chartDataSet2.drawFilledEnabled = true
        radarChartView.yAxis.gridAntialiasEnabled = true
        radarChartView.animate(yAxisDuration: 2.0)
        radarChartView.xAxis.valueFormatter = IndexAxisValueFormatter.init(values: subjects)
        
        radarChartView.yAxis.drawLabelsEnabled = false
        radarChartView.xAxis.axisMinimum = 0;
        radarChartView.xAxis.axisMaximum = 400;
        
        // Set color on radar chart  X axis
        radarChartView.xAxis.labelTextColor = UIColor.init(netHex: 0xE8A322)
        radarChartView.legend.form = Legend.Form.circle
        // combine both data
        let chartData = RadarChartData(dataSet: chartDataSet)
        chartData.addDataSet(chartDataSet2)
        radarChartView.data = chartData
        
    }
    
    
    /// Function sets up the colors depedning upon the indicators values.
    ///
    /// - Parameter value: Indicators value.
    /// - Returns: UI Color
    func cherryPickColour(value: Int) -> UIColor
    {
        if (value > 3)
        {
            return UIColor.init(netHex: 0x60CBB2)
        }
            
        else if (value == 3)
        {
            return UIColor.init(netHex: 0xFADD8A)
            
        }
            
        else{
            return UIColor.init(netHex: 0xED6985)
            
            
        }
    }
    
    
    // Dismiss the Comparison view when the back button is pressed.
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    /// Function determines the number of rows in the collection view.
    ///
    /// - Parameters:
    ///   - collectionView: System Defined Params
    ///   - section: System Defined Params
    /// - Returns: Number of rows required.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.collectionView3)
        {
            return financialIndicators.count
        }
        
        return Aselected1.count
    }
    
    
    /// Function used to configure the cell inside the collection view.
    ///
    /// - Parameters:
    ///   - collectionView: System Defined Params
    ///   - indexPath: System Defines params
    /// - Returns: Configured Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var scoreNumber = [70, 50, 20,30]
        // Inside this if statement setup the score chart
        if collectionView == self.collectionViewB {
            var temp_Company = Aselected1[indexPath.row]
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "score", for: indexPath) as! ScoreCollectionViewCell
            cellB.setupCompaniesName(companies: &temp_Company, score: scoreNumber[indexPath.row])
            cellB.layer.borderColor = UIColor.black.cgColor
            cellB.layer.borderWidth = 0.5
            cellB.layer.cornerRadius = 10.0
            
            
            return cellB
        }
        
        if collectionView == self.collectionView3{
            
            let indicator = financialIndicators[indexPath.row]
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "indicators", for: indexPath) as! CollectionViewCell3
            cell3.layer.cornerRadius = 12.0
            cell3.setIndicatorsLabel(indicator: indicator)
            
            return cell3
            
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComparisonCell", for: indexPath) as! ComparisonCollectionViewCell
        
        cell.company_name.text = Aselected1[indexPath.row].identifiers.name
        cell.layer.cornerRadius = 10.0
        // The color of the cell should depend upon the
        //cell.backgroundColor = UIColor.init(netHex: 0x)
        // print(Aselected.count)
        return cell
        
    }
    
    var selectedIndexPath: IndexPath?
    var previoud:IndexPath?
    
    /// When the user selets an indicator it changes it colors.
    ///
    /// - Parameters:
    ///   - collectionView: System Defined Params.
    ///   - indexPath: System Defined Params.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == self.collectionView3) {
            collectionView3.cellForItem(at: indexPath)?.backgroundColor = UIColor.init(netHex: 0x3C4F7B)
            
            //  MARK: This allows you to access cell elements
            let cell =  collectionView.cellForItem(at: indexPath) as! CollectionViewCell3
            // cell.label.textColor = .white
            
            if(selectedIndexPath != nil)
            {
                collectionView3.cellForItem(at: selectedIndexPath!)?.backgroundColor = UIColor.white
                
                // cell.label.textColor = .black
                
            }
            selectedIndexPath = indexPath
            
            
            /// changes the line chart to show Safety indicators
            
            if(indexPath.row == 4)
            {
                // change the data
                var performanceValues1 = [0,1,2,3,4]
                print("Habibi Hector")
                performanceValues1.removeAll()
                performanceValues1.append(Int(Aselected1[0].getSafety()))
                performanceValues1.append(Int(Aselected1[0].getSafety2()))
                performanceValues1.append(Int(Aselected1[0].getSafety3()))
                performanceValues1.append(Int(Aselected1[0].getSafety4()))
                performanceValues1.append(Int(Aselected1[0].getSafety5()))
                
                var performanceValues2 = [0,1,2,3,4]
                performanceValues2.removeAll()
                performanceValues2.append(Int(Aselected1[1].getSafety()))
                performanceValues2.append(Int(Aselected1[1].getSafety2()))
                performanceValues2.append(Int(Aselected1[1].getSafety3()))
                performanceValues2.append(Int(Aselected1[1].getSafety4()))
                performanceValues2.append(Int(Aselected1[1].getSafety5()))
                
                print("haibibi naveen",performanceValues2[0])
                print("haibibi naveen",performanceValues2[1])
                print("haibibi naveen",performanceValues2[2])
                print("haibibi naveen",performanceValues2[3])
                print("haibibi naveen",performanceValues2[4])
                //setupLineChart()
                setupLineChart2(score_Values: performanceValues1, score_Values1: performanceValues2)
            }
            
            /// changes the line chart to show Health indicators
            
            if(indexPath.row == 1)
            {
                setupLineChart()
            }
            
            /// changes the line chart to show Performance indicators
            
            if(indexPath.row == 2)
            {
                // change the data
                var performanceValues1 = [0,1,2,3,4]
                print("Habibi Hector")
                performanceValues1.removeAll()
                performanceValues1.append(Int(Aselected1[0].getPerformance()))
                performanceValues1.append(Int(Aselected1[0].getPerformance2()))
                performanceValues1.append(Int(Aselected1[0].getPerformance3()))
                performanceValues1.append(Int(Aselected1[0].getPerformance4()))
                performanceValues1.append(Int(Aselected1[0].getPerformance5()))
                
                var performanceValues2 = [0,1,2,3,4]
                performanceValues2.removeAll()
                performanceValues2.append(Int(Aselected1[1].getPerformance()))
                performanceValues2.append(Int(Aselected1[1].getPerformance2()))
                performanceValues2.append(Int(Aselected1[1].getPerformance3()))
                performanceValues2.append(Int(Aselected1[1].getPerformance4()))
                performanceValues2.append(Int(Aselected1[1].getPerformance5()))
                
                //setupLineChart()
                setupLineChart2(score_Values: performanceValues1, score_Values1: performanceValues2)
                
            }
            
            /// changes the line chart to show Strength indicators
            
            if(indexPath.row==3)
            {
                //strength
                // change the data
                var performanceValues1 = [0,1,2,3,4]
                print("Habibi Hector")
                performanceValues1.removeAll()
                performanceValues1.append(Int(Aselected1[0].getStrength()))
                performanceValues1.append(Int(Aselected1[0].getStrength2()))
                performanceValues1.append(Int(Aselected1[0].getStrengt3()))
                performanceValues1.append(Int(Aselected1[0].getStrength4()))
                performanceValues1.append(Int(Aselected1[0].getStrength5()))
                
                var performanceValues2 = [0,1,2,3,4]
                performanceValues2.removeAll()
                performanceValues2.append(Int(Aselected1[1].getStrength()))
                performanceValues2.append(Int(Aselected1[1].getStrength2()))
                performanceValues2.append(Int(Aselected1[1].getStrengt3()))
                performanceValues2.append(Int(Aselected1[1].getStrength4()))
                performanceValues2.append(Int(Aselected1[1].getStrength5()))
                
                //setupLineChart()
                setupLineChart2(score_Values: performanceValues1, score_Values1: performanceValues2)
            }
            
            /// changes the line chart to show return indicators
            if(indexPath.row==5)
            {
                // returns
                var performanceValues1 = [0,1,2,3,4]
                print("Habibi Hector")
                performanceValues1.removeAll()
                performanceValues1.append(Int(Aselected1[0].getReturns()))
                performanceValues1.append(Int(Aselected1[0].getReturns2()))
                performanceValues1.append(Int(Aselected1[0].getReturns3()))
                performanceValues1.append(Int(Aselected1[0].getReturns2()))
                performanceValues1.append(Int(Aselected1[0].getReturns5()))
                
                var performanceValues2 = [0,1,2,3,4]
                performanceValues2.removeAll()
                performanceValues2.append(Int(Aselected1[1].getReturns()))
                performanceValues2.append(Int(Aselected1[1].getReturns2()))
                performanceValues2.append(Int(Aselected1[1].getReturns3()))
                performanceValues2.append(Int(Aselected1[1].getReturns4()))
                performanceValues2.append(Int(Aselected1[1].getReturns5()))
                
                //setupLineChart()
                setupLineChart2(score_Values: performanceValues1, score_Values1: performanceValues2)
            }
            
        }
    }
    
    
    
}

// MARK: - Use to setup the table view.
extension ComparisonController2: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ratios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratio", for: indexPath)as! TableViewCell
        let name = ratios[indexPath.row]
        let value = ratiosValue[indexPath.row]
        cell.setupLabel(name: name)
        cell.setupLabelValue(value: value)
        if(indexPath.row == 0)
        {
            cell.backgroundColor = UIColor.init(netHex: 0x3C4F7B)
            cell.ratioName.textColor = .white
            cell.ratioValue.isHidden = true
        }
        if(indexPath.row == 4)
        {
            cell.backgroundColor = UIColor.init(netHex: 0x3C4F7B)
            cell.ratioName.textColor = .white
            cell.ratioValue.isHidden = true
            
        }
        
        if(indexPath.row == 8)
        {
            cell.backgroundColor = UIColor.init(netHex: 0x3C4F7B)
            cell.ratioName.textColor = .white
            cell.ratioValue.isHidden = true
            
        }
        
        return cell
        
    }
}
