//
//  ShowViewController.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 07/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import UIKit
import Gloss

class ShowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cat = ""
    var fromDate = ""
    var toDate = ""
    var panels = [Panel]()
    var compo = [Component]()
    var dataData = [DataData]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupAPI()
        tableView.reloadData()
        self.title = "Group Level"
        tableView.tableFooterView = UIView()
        
    }
    
    func setupAPI(){
        
        let url = URL(string: "http://bi.skg.adevo.io/bi/dashboard-panels?id=54&&startDate=\(fromDate)&&endDate=\(toDate)&&intervalType=daily&&mode=edit&&shopId=\(cat)&&token=verycoolbisystem")
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
                    
                    
                    self.populateData(dictData)
                    //print(dictData)
                }
            }catch{
                print("Error when converting JSON")
            }
            
        }
        task.resume()
    }
    
    func populateData(_ dict: [String: Any]){
        guard let responseDict = dict["response"] as? [String : Any],
            let dataDict = responseDict["data"] as? [String:Any],
            let panelsJson = dataDict["panels"] as? [JSON] else {
                return
        }
        
        panels = [Panel].from(jsonArray: panelsJson) ?? []
        
        
        DispatchQueue.main.async {
        self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return panels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell()}
        cell.textLabel?.text = panels[indexPath.row].title
        cell.detailTextLabel?.text = "\("Skorstensgaard ")\(panels[indexPath.row].type)"
    
//        \(venues[indexPath.row].procedureName)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            detailController.panel = panels[indexPath.row]
            detailController.components = panels[indexPath.row].components
        
            navigationController?.pushViewController(detailController, animated: true)
        }
    }
}//end

