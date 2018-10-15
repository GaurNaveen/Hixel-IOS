//
//  TestViewController.swift
//  Hixel IOS App
//
//  Created by Naveen Gaur on 10/10/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit
import Charts
class TestViewController: UIViewController {

    @IBOutlet weak var radarChart: RadarChartView!
    //Label
    let subjects = ["Health", "Safety", "Performance", "Revenue", "Biology"]
    let activities = ["Burger", "Steak", "Salad", "Pasta", "Pizza"]

    //Points
    let array = [1.0, 2.0, 3.0, 4.0, 5.0]
    var searchArray = [SearchEntry]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       setChart(dataPoints: subjects, values: array)
      //  set(dataPoints: subjects, values: array)

    }
    
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
   func setChart(dataPoints: [String], values: [Double]) {
    radarChart.noDataText = "You need to provide data for the chart."
    var dataEntries: [ChartDataEntry] = []
    for i in 0..<dataPoints.count {
    
        let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
       // print(values[i])
        dataEntries.append(dataEntry)
    }
    let chartDataSet = RadarChartDataSet(values: dataEntries, label: "Apple ")
    //Options of radarChart
    radarChart.sizeToFit()
   //radarChart.description = "as"
    
    //Options for the axis from here. The range is 0-100, the interval is 20
    radarChart.yAxis.labelCount = 6
   // radarChart.yAxis.axisMinimum = 0.0
    //radarChart.yAxis.axisMaximum = 100.0
    
    radarChart.rotationEnabled = true
    chartDataSet.drawFilledEnabled = true
    
    
    //Other options
   // radarChart.legend.enabled = false
    radarChart.yAxis.gridAntialiasEnabled = true
    radarChart.animate(yAxisDuration: 2.0)
    radarChart.xAxis.valueFormatter = IndexAxisValueFormatter.init(values: subjects)
   // let chartData = RadarChartData(xVals: subjects, dataSet: chartDataSet)
    //radayAxis.drawLabelsEnabled = false
    radarChart.yAxis.drawLabelsEnabled = false
    radarChart.xAxis.axisMinimum = 0;
    radarChart.xAxis.axisMaximum = 500;
    let chartData = RadarChartData(dataSet: chartDataSet)

    radarChart.data = chartData

    }
    
    
    

}

