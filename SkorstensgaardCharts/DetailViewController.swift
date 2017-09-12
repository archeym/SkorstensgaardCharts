//
//  DetailViewController.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 07/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import UIKit
import Charts

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //var reviewText = [String]()
    var panel : Panel!
    var components : [Component]!
    var columns : [Columns]!

    var data: DataData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Some Title"
        tableView.dataSource = self
        tableView.reloadData()
        titleLabel.text = panel.title
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toData", let row = tableView.indexPathForSelectedRow?.row {
            let nextVc = segue.destination as! DataViewController
            nextVc.compData = components[row].componentData
        }
    }
} //end

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = components[indexPath.row].componentData.first?.title ?? ""
        cell.detailTextLabel?.text = components[indexPath.row].componentData.first?.value ?? ""
        
        return cell
    }
}

















