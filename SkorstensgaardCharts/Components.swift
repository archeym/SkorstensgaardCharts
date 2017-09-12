//
//  Components.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 08/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import Foundation
import Gloss

class Component: Decodable {

    var type: String = ""
    var id : String
    var componentData : [DataData] = []

    init(id : String) {
        self.id = id
    }
    required init?(json: JSON) {
        guard let id: String = "id" <~~ json else {return nil}
        self.id = id
        self.type = "type" <~~ json ?? ""
        
        if let dataJson: JSON = "data" <~~ json,
           let dataJsonArr: [JSON] = "data" <~~ dataJson {
            
            self.componentData = [DataData].from(jsonArray: dataJsonArr) ?? []
            
        }
    }
    
}
