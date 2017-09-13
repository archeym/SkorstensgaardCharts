//
//  DataService.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 12/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import Foundation

class DataService {
    
    static let shared = DataService()
    
    private init() {}
    
    func getData(){
        
        let url = URL(string: "http://bi.skg.adevo.io/bi/dashboard-panels?id=54&&startDate=2017-09-01&&endDate=2017-09-09&&intervalType=daily&&mode=edit&&shopId=2&&token=verycoolbisystem")
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
                    
                    
                    //self.populateData(dictData)
                    //print(dictData)
                }
            }catch{
                print("Error when converting JSON")
            }
            
        }
        task.resume()
    }

    
}
