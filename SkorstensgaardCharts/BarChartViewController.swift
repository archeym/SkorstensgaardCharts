//
//  BarChartViewController.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 05/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import UIKit
import Charts
import WebKit

class BarChartViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var barChartView2: BarChartView!
    
    @IBOutlet weak var chartNumberLabel1: UILabel!
    
    var units: [String]!
    var months: [String]!
    var units2: [String]!
    var months2: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bar Charts"
        months = ["","2495", "2787", "3354", "1887", "5061", "4347", "1656"]
        units = ["","2495", "2787", "3354", "1887", "5061", "4347", "1656"]
        setChart(dataPoints: months, values: units)
        
        months2 = ["","2095", "2787", "3354", "1887", "5061", "3914","3179"]
        units2 = ["", "3029", "3598", "3260", "2074", "4178", "3914","3179"]
        setChart2(dataPoints2: months2, values: units2)
        
        barChartSetup()
        //setupAPI()
        //setupProfile()
    }
    
    func setupAPI(){
        
        let url = URL(string: "http://bi.skg.adevo.io/bi/dashboard-panels?id=75&&startDate=2017-09-01&&endDate=2017-09-20&&intervalType=daily&&mode=edit&&shopId=6&&token=verycoolbisystem")
        var urlRequest = URLRequest(url: url!)
                
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: urlRequest) { (data, responce, error) in
            
            if let err = error {
                print("Error \(err.localizedDescription)")
                return
            }
            guard let data = data
                else{
                    print("data error")
                    return
            }
            print(data)
            do{
                if let dictData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    
                    print(dictData)
                    //self.populateData(dictData)
                    self.setupProfile()
                }
            }catch{
                print("Error when converting JSON")
            }
            
        }
        task.resume()
    }
    
    func setupProfile(){
        //self.chartNumberLabel1.text = self.panelTitel.title
    }
    
    func barChartSetup(){
        self.barChartView.animate(xAxisDuration: 0.5, yAxisDuration: 1.0, easingOption: .easeInOutQuart)
        self.barChartView2.animate(xAxisDuration: 2.0, yAxisDuration: 1.0, easingOption: .easeInBack)
        
    }
    func setChart2(dataPoints2: [String], values: [String]) {
        
        var dataEntries2 = [BarChartDataEntry]()
        for i in 1..<dataPoints2.count {
            
            let dataEntry2 = BarChartDataEntry(x: Double(i), y: Double(values[i])!)
            dataEntries2.append(dataEntry2)
            
            let dataSet = BarChartDataSet(values: dataEntries2, label: "")
            dataSet.colors = [UIColor(red: 40/255, green: 85/255, blue: 106/255, alpha: 1.0)]
            let chartData2 = BarChartData(dataSets: [dataSet])
            chartData2.addDataSet(dataSet)
            chartData2.setDrawValues(true)
            barChartView2.data = chartData2
        }
    }
    
    func setChart(dataPoints: [String], values: [String]) {
        
        var dataEntries = [BarChartDataEntry]()
        for i in 1..<dataPoints.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i])!)
            dataEntries.append(dataEntry)
            
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        chartDataSet.colors = [UIColor(red: 40/255, green: 85/255, blue: 106/255, alpha: 1.0)]
        let chartData = BarChartData(dataSets: [chartDataSet])
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        
        let xAxis: XAxis = self.barChartView.xAxis;
        barChartView.xAxis.valueFormatter = xAxis.valueFormatter
        setBarChartStyle()
        barChartView.data = chartData
        

    }
    
    func setBarChartStyle(){
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.chartDescription?.enabled = false
        barChartView.legend.enabled = true
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = true
        
        barChartView2.noDataText = "You need to provide data for the chart."
        barChartView2.xAxis.labelPosition = .bottom
        barChartView2.xAxis.drawGridLinesEnabled = false
        barChartView2.chartDescription?.enabled = false
        barChartView2.legend.enabled = true
        barChartView2.rightAxis.enabled = false
        barChartView2.leftAxis.drawGridLinesEnabled = false
        barChartView2.leftAxis.drawLabelsEnabled = true
    }
}
