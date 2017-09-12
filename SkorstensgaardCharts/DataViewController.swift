//
//  DataViewController.swift
//  SkorstensgaardCharts
//
//  Created by Arkadijs Makarenko on 09/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var compData: [DataData]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return compData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        
        cell.textLabel?.text = compData[indexPath.row].title
        cell.detailTextLabel?.text = compData[indexPath.row].value
        
        return cell
    }
}
