//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var chartNumber1: UILabel!
    
    var currentChart: Chart!
    
    var units: [String]!
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Some Title"
        setupAPI()
        
         //let chartsBar = ["Day 1"]
        
        
//        let winningStreak =  ["Wins"]
//       let units = [winStreak]
//       setWinStreakChart(dataPoints: winningStreak, values: gamesWon)
//        
//        let defaults = UserDefaults.standard
//        let Email = defaults.string(forKey: "userEmail")
//        let playerId = defaults.string(forKey: "playerId")
//        let commsId = defaults.string(forKey: "communityId")
        
        
        
        months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        units = ["20", "4", "6", "3", "12", "16", "4", "18", "2", "4", "5", "4"]
        barChartSetup()
        setChart(dataPoints: months, values: units)
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
        
        chartView.noDataText = "You need to provide data for the chart."
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.chartDescription?.enabled = false
        chartView.legend.enabled = true
        chartView.rightAxis.enabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawLabelsEnabled = true
    }
    
    func setupAPI(){
        
        let url = URL(string: "http://bi.skg.adevo.io/bi/dashboard-panels?id=75&&startDate=2017-09-01&&endDate=2017-09-20&&intervalType=daily&&mode=edit&&shopId=6&&token=verycoolbisystem")
        var urlRequest = URLRequest(url: url!)
        
        let postString = "id=75&&startDate=2017-09-01&&endDate=2017-09-20&&intervalType=daily&&mode=edit&&shopId=6&&token=verycoolbisystem"
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8);
        
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let validError = error {
                print(validError.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                         print (jsonResponse)
                        
                        if let dict = jsonResponse as? [String:Any]{
                            if let dictionary = dict["procedure_name"] as? [String:Any]   {
                                self.currentChart = Chart(dict: dictionary)
                            }

                        }
                        DispatchQueue.main.async {
                            self.setupProfile()
                            
                        }
                    } catch let jsonError as NSError {
                        print(jsonError)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func setupProfile(){
        self.chartNumber1.text = self.currentChart.procedureName
    }
    
    
    
    func barChartSetup(){

        self.barChartView.animate(xAxisDuration: 0.5, yAxisDuration: 1.0, easingOption: .easeInCirc)
        self.chartView.animate(xAxisDuration: 2.0, yAxisDuration: 1.0, easingOption: .easeInCirc)
    
    }
    
    func setChart(dataPoints: [String], values: [String]) {
        
        var dataEntries = [BarChartDataEntry]()
        
        for i in 0..<dataPoints.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i])!)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units")
        chartDataSet.colors = [UIColor(red: 40/255, green: 85/255, blue: 106/255, alpha: 1.0)]
        let chartData = BarChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        
        let xAxis: XAxis = self.barChartView.xAxis;
        barChartView.xAxis.valueFormatter = xAxis.valueFormatter
        setBarChartStyle()
        barChartView.data = chartData
        
        let dataSet = BarChartDataSet(values: dataEntries, label: "Units")
        dataSet.colors = [UIColor(red: 40/255, green: 85/255, blue: 106/255, alpha: 1.0)]
        let chartData2 = BarChartData()
        chartData2.addDataSet(dataSet)
        chartData2.setDrawValues(true)
        chartView.data = chartData
        
 
    }

}

