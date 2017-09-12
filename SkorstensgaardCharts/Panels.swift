//
//  Panels.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 05/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import Foundation
import Gloss

class Panel: Decodable {
    
    var id: Int
    var title: String = ""
    var value : String = ""
    var type: String = ""
    var components: [Component] = []
    var dataColumns: [Columns] = []
    
    init(id: Int) {
        self.id = id
    }
    
    required init?(json: JSON) {
        guard let id: Int = "id" <~~ json else {return nil}
        self.id = id
        self.title = "title" <~~ json ?? ""
        self.type = "type" <~~ json ?? ""
        
        if let compJSON: [JSON] = "components" <~~ json {
            self.components = [Component].from(jsonArray: compJSON) ?? []
            self.dataColumns = [Columns].from(jsonArray: compJSON) ?? []
            
        }
      
    }
}//end
