//
//  ViewController.swift
//  todoApp
//
//  Created by Meitar Basson on 15/04/2020.
//  Copyright © 2020 Meitar Basson. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryTable: UITableView!
    
    var categories: [Category]?
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        categoryTable.delegate = self
        categoryTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let categories = categories {
            return categories.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = categoryTable.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? categoryCell {
//            cell.configureCell(category: ])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let categoryVC = segue.destination as? CategoryVC {
//            categoryVC.category =
        }
    }
    
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        print("Add pressed")
    }
    
}

