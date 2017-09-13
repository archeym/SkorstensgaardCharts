//
//  Columns.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 11/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import Foundation
import SwiftyJSON

class Columns  {
    
    var title : String
    var components : String
    var panels : [Panel] = []
    
    init?(data: Data) {
    
        let json = JSON(data:data)
        
        guard let components = json[1]["data"]["data"]["columns"].string,
            let title = json[1]["title"].string else { return nil }
        
        self.components = components
        self.title = title
    }
    
}

