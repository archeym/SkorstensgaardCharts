//
//  Panels.swift
//  iOSChartsDemo
//
//  Created by Arkādijs Makarenko on 04/09/2017.
//  Copyright © 2017 Appcoda. All rights reserved.
//

import Foundation

class Panels {
    
    var id: Int = 0
    var title: String = ""
    var panelId: String = ""
    
    init (dict : [String: Any] ) {
        title = dict["type"] as? String ?? ""
        id = dict["id"] as? Int ?? 0
        panelId = dict["panelId"] as? String ?? ""
        
    }
}
