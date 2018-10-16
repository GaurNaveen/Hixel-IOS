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
    //var selectedCompanies = ["Apple Inc","Samsung Corp","Alphabet","Bmw","Facebook"]
    @IBOutlet weak var lineChartView: LineChartView!
  //  @IBOutlet weak var radarChartView: RadarChartView!
    @IBOutlet weak var radarChartView: RadarChartView!
    
    @IBOutlet weak var collectionView3: UICollectionView!
    // Arrays that holds the Financial Indicators values
    var financialIndicatorsValue = [4,3,2]
    var financialIndicators = ["Financial Indicators","Health","Performance","Strength","Safety","Return"]
    var ratios = ["Liquidity Ratio","Debt Ratio","P/E Ratio"]
    let subjects = ["Health", "Safety", "Performance", "Revenue", "Strength"]
    
    var ratiosValue = [0,1.2,1.3,0.5,0,1.45,0.29,0.45,0,1.34,1.67,0.6]
    @IBAction func info(_ sender: Any) {
        // performSegue(withIdentifier: "comparison_info", sender: self) port_graphinfo2
        performSegue(withIdentifier: "comparison_graph2", sender: self)
    }
    //Points
    let array = [1.0, 2.0, 3.0, 4.0, 5.0]
    let array2 = [5.0, 6.0, 2.0, 1.0, 5.0]
    @IBOutlet weak var graphContainerView: UIView!
    
    @IBOutlet weak var graphHeaderView: UIView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    // Contains all the companies user have selected
    var Aselected: [TempCompany] = []
    var companiesSelected : [SearchEntry] = []
    let shapeLayer = CAShapeLayer()
    var Aselected1: [Company] = []
    @IBOutlet weak var horizontalLine: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("klopp",Aselected1)
        graphHeaderView.dropShadow()
        graphContainerView.dropShadow()
        graphContainerView.layer.borderColor = UIColor.black.cgColor
        graphContainerView.layer.borderWidth = 0.4
        
        // Do any additional setup after loading the view.
        
        setupLineChart()
        setUpRadarChart(dataPoints: subjects, values: array, values2: array2)
    }
    
    // MARK: Setup Line Chart
    func setupLineChart()
    {
        var lineChartEntry = [ChartDataEntry]()
        var lineChartEntry2 = [ChartDataEntry]()
        var score_Values = [1,3,2,4,3]
        var score_Values1 = [2,1,5,1,2]
        let years = ["2014","2015","2016","2017","2018"]
        
        for i in 0..<score_Values.count {
            let value = ChartDataEntry(x: Double(i), y: Double(score_Values[i]))
            lineChartEntry.append(value)
        }
        
        for i in 0..<score_Values1.count {
            let value = ChartDataEntry(x: Double(i), y: Double(score_Values1[i]))
            lineChartEntry2.append(value)
        }
        let set1 = LineChartDataSet(values: lineChartEntry, label: Aselected[0].name)
        let set2 = LineChartDataSet(values: lineChartEntry2, label: Aselected[1].name)
        
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
    
    
    // MARK: Setup Radar chart
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
        let chartDataSet = RadarChartDataSet(values: dataEntries, label: "Apple ")
        
        // For Second Company
        var dataEntries2:[ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            
            let dataEntry = ChartDataEntry(x: Double(i), y: values2[i])
            // print(values[i])
            dataEntries2.append(dataEntry)
        }
        let chartDataSet2 = RadarChartDataSet(values: dataEntries2, label: "Samsung ")
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.collectionView3)
        {
            return financialIndicators.count
        }
        
        return Aselected.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var scoreNumber = [70, 50, 20,30]
        // Inside this if statement setup the score chart
        if collectionView == self.collectionViewB {
            let temp_Company = Aselected[indexPath.row]
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "score", for: indexPath) as! ScoreCollectionViewCell
            cellB.setupCompaniesName(companies: temp_Company, score: scoreNumber[indexPath.row])
            cellB.layer.borderColor = UIColor.black.cgColor
            cellB.layer.borderWidth = 0.5
            cellB.layer.cornerRadius = 10.0
            
            // Add the Score chart
            
            
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
        
        cell.company_name.text = Aselected[indexPath.row].name
        cell.layer.cornerRadius = 10.0
        // The color of the cell should depend upon the
        //cell.backgroundColor = UIColor.init(netHex: 0x)
        // print(Aselected.count)
        return cell
        
    }
    
    var selectedIndexPath: IndexPath?
    var previoud:IndexPath?
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
            
            
        }
    }
    
    
    
}

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
