//
//  DataData.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 08/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import Foundation
import Gloss

class DataData: Decodable {
    var title : String = ""
    var value : String = ""
    var type : String
    
    init(type: String){
        self.type = type
    }
    
    required init?(json: JSON) {
        guard let type: String = "type" <~~ json else {
            return nil
        }
        self.type = type
        if let dataJson: [JSON] = "data" <~~ json,
           let titleJson: JSON = dataJson.first,
           let valueJson: JSON = dataJson.last {
            
            self.title = "value" <~~ titleJson ?? ""
            self.value = "value" <~~ valueJson ?? ""
        }
    }
}
