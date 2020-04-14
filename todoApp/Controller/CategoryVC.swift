//
//  CategoryVC.swift
//  todoApp
//
//  Created by Meitar Basson on 15/04/2020.
//  Copyright © 2020 Meitar Basson. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemTable: UITableView!
    
    var items: [Item]?
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemTable.delegate = self
        itemTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = items {
            return item.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = itemTable.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? itemCell {
//            cell.configureCell(item: )
            return cell
        }
        return UITableViewCell()
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        print("Add pressed")
    }
    
}
