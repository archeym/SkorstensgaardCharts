//
//  ChartsController.swift
//  iOSChartsDemo
//
//  Created by Arkādijs Makarenko on 04/09/2017.
//  Copyright © 2017 Appcoda. All rights reserved.
//

import Foundation

class ChartsController {
    
    static let baseURL = URL(string: "http://bi.skg.adevo.io/bi/dashboard-panels?id=75&&startDate=2017-09-01&&endDate=2017-09-20&&intervalType=daily&&mode=edit&&shopId=6&&token=verycoolbisystem")
    
    static func showCharts(query: String, completion: @escaping ([Chart]) -> Void) {
        guard let url = baseURL else { completion([]); return }
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: ["api_key" : "bi/dashboard-panels", "language": "en-US", "query": query]) { (data, error) in
            guard let data = data, let response = String(data: data, encoding: .utf8) else {
                NSLog("No data were received.")
                completion([])
                return
            }
            guard let returnedDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                let chartDict = returnedDict["results"] as? [[String: Any]] else { NSLog("Could not parse json. \n Response: \(response)"); completion([]); return }
            
            let charts = chartDict.flatMap { Chart(dict: $0) }
            
            completion(charts)
        }
    }
}
