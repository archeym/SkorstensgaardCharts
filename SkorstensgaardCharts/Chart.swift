//
//  Chart.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 05/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import Foundation

class Chart {
    
    var type: String = ""
    var id: String = ""
    var chartId: String = ""
    var procedureName: String = ""
    var columns: String = ""
    
    
    init (dict : [String: Any] ) {
        type = dict["type"] as? String ?? ""
        id = dict["id"] as? String ?? ""
        chartId = dict["chartId"] as? String ?? ""
        procedureName = dict["procedure_name"] as? String ?? ""
        columns = dict["Day 1"] as? String ?? ""
        
    }
    
}
