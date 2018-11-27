//
//  TestViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 10/10/18.
//

import UIKit
import Charts
import MaterialComponents
import MaterialComponents
class TestViewController: UIViewController {
    
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var radarChart: RadarChartView!
    //Label
    @IBOutlet weak var barChartView: BarChartView!
    let subjects = ["Health", "Safety", "Performance", "Revenue", "Strength"]
    
    //Points
    let array = [1.0, 2.0, 3.0, 4.0, 5.0]
    let array2 = [5.0, 6.0, 2.0, 1.0, 5.0]
    var searchArray = [SearchEntry]()
    var months : [String]!
    
    override func viewDidLoad() {
        addFloatingButton()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // setChart(dataPoints: subjects, values: array,values1:array2 )
        //  set(dataPoints: subjects, values: array)
        months = ["Health", "Performance", "Return", "Risk", "Strength"]
        let yvalues = [3.0,4.0,1.0,2.0,5.0]
        setChart(dataPoints: months, values: yvalues)
    }
    
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func addFloatingButton()
    {  //view.backgroundColor = UIColor.black
        
        
        let plusImage = UIImage.init(imageLiteralResourceName: "Plus_Image")
        let button = MDCFloatingButton()
        button.setImage(plusImage, for: .normal)
      //  MDCFloatingButton
        //MDCFloatingButton.
        button.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        button.minimumSize = CGSize(width: 64, height: 48)
        let buttonScheme = MDCButtonScheme()
        MDCFloatingActionButtonThemer.applyScheme(buttonScheme, to: button)
        button.setMinimumSize(CGSize(width: 96, height: 40), for: .mini, in: .expanded)
        button.minimumSize = CGSize(width: 64, height: 48)

        view.addSubview(button)
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.legend.enabled = false
        barChartView.drawValueAboveBarEnabled = false
        barChartView.drawBarShadowEnabled = false
        var dataEntries : [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
            
            
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        chartDataSet.setColors(UIColor.init(netHex: 0xFFDD7C),UIColor.init(netHex: 0x1DCEB1),UIColor.init(netHex: 0xFF5D84),UIColor.init(netHex: 0xFF5D84),UIColor.init(netHex: 0x1DCEB1))
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.2
        chartData.setDrawValues(false)
        
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
        barChartView.rightAxis.enabled = false
        
        
        barChartView.data = chartData
        barChartView.xAxis.labelPosition = .bottom
        barChartView.backgroundColor = UIColor.white
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    //    func setChart(dataPoints: [String], values: [Double],values1:[Double]) {
    //        radarChart.noDataText = "You need to provide data for the chart."
    //        var dataEntries: [ChartDataEntry] = []
    //        for i in 0..<dataPoints.count {
    //
    //            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
    //            // print(values[i])
    //            dataEntries.append(dataEntry)
    //        }
    //        let chartDataSet = RadarChartDataSet(values: dataEntries, label: "Apple ")
    //
    //        // Second data
    //        var dataEntries2:[ChartDataEntry] = []
    //
    //        for i in 0..<dataPoints.count {
    //
    //            let dataEntry = ChartDataEntry(x: Double(i), y: values1[i])
    //            // print(values[i])
    //            dataEntries2.append(dataEntry)
    //        }
    //        let chartDataSet2 = RadarChartDataSet(values: dataEntries2, label: "Apple ")
    //
    //        //Fills the color
    //        chartDataSet.fillColor = UIColor.red
    //
    //        //radarChart.webColor = UIColor.red
    //        //radarChart.innerWebColor =   UIColor.red
    //        //Options of radarChart
    //        radarChart.sizeToFit()
    //        //radarChart.description = "as"
    //
    //        //Options for the axis from here. The range is 0-100, the interval is 20
    //        radarChart.yAxis.labelCount = 6
    //        // radarChart.yAxis.axisMinimum = 0.0
    //        //radarChart.yAxis.axisMaximum = 100.0
    //
    //        radarChart.rotationEnabled = true
    //        chartDataSet.drawFilledEnabled = true
    //        chartDataSet2.drawFilledEnabled = true
    //
    //        //Other options
    //        // radarChart.legend.enabled = false
    //        radarChart.yAxis.gridAntialiasEnabled = true
    //        radarChart.animate(yAxisDuration: 2.0)
    //        radarChart.xAxis.valueFormatter = IndexAxisValueFormatter.init(values: subjects)
    //        // let chartData = RadarChartData(xVals: subjects, dataSet: chartDataSet)
    //        //radayAxis.drawLabelsEnabled = false
    //        radarChart.yAxis.drawLabelsEnabled = false
    //        radarChart.xAxis.axisMinimum = 0;
    //        radarChart.xAxis.axisMaximum = 500;
    //
    //        // combine both data
    //        let chartData = RadarChartData(dataSet: chartDataSet)
    //        //let chartData = RadarChartData(dataSet: [chartDataSet,chartDataSet2] as? IChartDataSet)
    //        chartData.addDataSet(chartDataSet2)
    //        radarChart.data = chartData
    //
    //    }
    //
    
    
    
}

