//
//  TableViewController.swift
//  SkorstensgaardCharts
//
//  Created by Arkādijs Makarenko on 05/09/2017.
//  Copyright © 2017 Arkādijs Makarenko. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITextFieldDelegate {

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        if let  viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShowViewController") as? ShowViewController{
            guard let text = searchTextField.text?.lowercased(), let fromDate = fromDate.text?.lowercased(), let toDate = toDate.text?.lowercased() else {
                return
            }
            viewController.cat = text
            viewController.fromDate = fromDate
            viewController.toDate = toDate
            navigationController?.pushViewController(viewController, animated: true)
            searchTextField.text? = ""
        }
    }
    
    
    @IBAction func logoutBarButton(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "AUTH_Token")
        defaults.synchronize()
        let initController = UIStoryboard(name: "Auth Storyboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "LogInViewController")
        present(initController, animated: true, completion: nil)
        
    }
    
    
    

}
