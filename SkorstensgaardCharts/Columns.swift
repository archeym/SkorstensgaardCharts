//
//  Columns.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 11/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import Foundation
import Gloss

class Columns: Decodable  {
    var x : String = ""
    var columns : [Component] = []
    var title : String = ""
    var value : String = ""
    var panels : [Panel] = []
    init(x: String){
        self.x = x
    }
    
    required init?(json: JSON) {
        guard let x: String = "x" <~~ json else { return nil }
        
        self.x = x
        if let columnsJson: [JSON] = "components" <~~ json{
            self.panels = [Panel].from(jsonArray: columnsJson) ?? []
    
    }
    }
    
}
