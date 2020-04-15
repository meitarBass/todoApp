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
    
    var items: [Item] = [Item]()
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemTable.delegate = self
        itemTable.dataSource = self
        
        navigationController?.title = category?.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = itemTable.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? itemCell {
            cell.configureCell(item: items[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Task", message: "Please enter a new task", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add New Item", style: .default) { _ in
            guard let text = textField.text else { return }
            let item = Item(title: text)
            self.items.append(item)
            self.itemTable.reloadData()
            textField.text = ""
        }
        
        if alert.actions.count == 0 {
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create New Task"
                textField = alertTextField
            }
            alert.addAction(action)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}
