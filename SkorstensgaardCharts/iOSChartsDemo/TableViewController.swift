//
//  TableViewController.swift
//  iOSChartsDemo
//
//  Created by Arkādijs Makarenko on 01/09/2017.
//  Copyright © 2017 Appcoda. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let label = UILabel()
//        label.text = "Charts "
//        label.font = UIFont(name:"supermolot-webfont", size: 30)
//        label.textColor = .white
//        label.sizeToFit()
//        
//        let label2 = UILabel()
//        label2.text = " List"
//        label2.font = UIFont(name:"supermolot_light_italic-webfont", size: 30)
//        label2.textColor = .white
//        label2.sizeToFit()
//        
//        
//        
//        let stackView = UIStackView(arrangedSubviews: [label,label2])
//        stackView.axis = .horizontal
//        stackView.frame.size.width = label.frame.width + label2.frame.width
//        stackView.frame.size.height = max(label.frame.height, label2.frame.height)
//        
//        navigationItem.titleView = stackView
        

    }

    @IBAction func logoutBarButton(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "AUTH_Token")
        defaults.synchronize()
        let initController = UIStoryboard(name: "Auth Storyboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "LogInViewController")
        present(initController, animated: true, completion: nil)
        
    }
 


}
