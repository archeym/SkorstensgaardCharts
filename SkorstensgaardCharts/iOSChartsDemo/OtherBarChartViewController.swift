//
//  OtherBarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Arkādijs Makarenko on 31/08/2017.
//  Copyright © 2017 Appcoda. All rights reserved.
//
import UIKit
import Charts

class OtherBarChartViewController: UIViewController {
    
    
    @IBOutlet weak var pieChartView: PieChartView!

    @IBOutlet weak var chartView: PieChartView!
    
 
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
        
        self.pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInQuad)
        self.chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeOutSine)
        setChart(dataPoints: months, values: units)
        
    }
    func setChart(dataPoints: [String], values: [String]) {
        
        pieChartView.chartDescription?.enabled = false
        pieChartView.legend.enabled = true
//        chartView.xAxis.labelPosition = .bottom
//        chartView.xAxis.drawGridLinesEnabled = false
        chartView.chartDescription?.enabled = false
        chartView.legend.enabled = true
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            
            let dataE = ChartDataEntry(x: Double(i), y: Double(values[i])!)
            dataEntries.append(dataE)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData()
        pieChartData.addDataSet(pieChartDataSet)
        pieChartData.setDrawValues(true)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = PieChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartView.data = chartData
        

    }
    
}
    
    
    
