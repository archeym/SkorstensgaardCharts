//
//  ChartViewController.swift
//  iOSChartsDemo
//
//  Created by Arkādijs Makarenko on 01/09/2017.
//  Copyright © 2017 Appcoda. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    @IBOutlet weak var radarChartView: RadarChartView!
    @IBOutlet weak var chartView: RadarChartView!
  
    var months: [String]!
    var units: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "some title"
        months = ["1", "2", "3", "4", "5", "6", "7", "8"]
        units = ["17", "4", "6", "3", "12", "16", "4", "11"]

        barChartSetup()
    }
    
    func barChartSetup(){
        
        self.radarChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInQuad)
        self.chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeOutSine)
        
        setChart(dataPoints: months, values: units)
        
    }
    
    func setChart(dataPoints: [String], values: [String]) {
        
        radarChartView.chartDescription?.enabled = false
        radarChartView.legend.enabled = true
        radarChartView.xAxis.labelPosition = .bottom
        radarChartView.xAxis.drawGridLinesEnabled = false
       
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.chartDescription?.enabled = false
        chartView.legend.enabled = true
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            
            let dataE = ChartDataEntry(x: Double(i), y: Double(values[i])!)
            dataEntries.append(dataE)
        }
        
        let radarChartDataSet = RadarChartDataSet(values: dataEntries, label: "Units Sold")
        let radarChartData = PieChartData()
        radarChartData.addDataSet(radarChartDataSet)
        radarChartData.setDrawValues(true)
        radarChartView.data = radarChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        radarChartDataSet.colors = colors
        
        let chartDataSet = RadarChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = PieChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartView.data = chartData
        
        chartDataSet.colors = colors
    }
    

}
