//
//  BarChartViewController.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 05/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var barChartView2: BarChartView!
    @IBOutlet weak var chartNumberLabel1: UILabel!
    
//    var panels: [Panels] = []
//    var panelTitel : Panels!
    var units: [String]!
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Some Title"
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dec"]
        units = ["20", "4", "6", "3", "12", "16", "4", "18", "2", "4", "5", "4"]
        barChartSetup()
        setChart(dataPoints: months, values: units)
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
        self.barChartView.animate(xAxisDuration: 0.5, yAxisDuration: 1.0, easingOption: .easeInCirc)
        self.barChartView2.animate(xAxisDuration: 2.0, yAxisDuration: 1.0, easingOption: .easeInOutQuart)
        
    }
    
    func setChart(dataPoints: [String], values: [String]) {
        
        var dataEntries = [BarChartDataEntry]()
        for i in 0..<dataPoints.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i])!)
            dataEntries.append(dataEntry)
            
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units")
        chartDataSet.colors = [UIColor(red: 40/255, green: 85/255, blue: 106/255, alpha: 1.0)]
        let chartData = BarChartData(dataSets: [chartDataSet])
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        
        let xAxis: XAxis = self.barChartView.xAxis;
        barChartView.xAxis.valueFormatter = xAxis.valueFormatter
        setBarChartStyle()
        barChartView.data = chartData
        
        let dataSet = BarChartDataSet(values: dataEntries, label: "Units")
        dataSet.colors = [UIColor(red: 40/255, green: 85/255, blue: 106/255, alpha: 1.0)]
        let chartData2 = BarChartData(dataSets: [dataSet])
        chartData2.addDataSet(dataSet)
        chartData2.setDrawValues(true)
        barChartView2.data = chartData

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
