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
        
        navigationItem.title = category?.title
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
        items[indexPath.row].changeCheckmarkSign()
        
        if items[indexPath.row].wasDone {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
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

//// Firebase Section for upload images online
//// Data in memory
//let data = Data()
//
//// Create a reference to the file you want to upload
//let riversRef = storageRef.child("images/rivers.jpg")
//
//// Upload the file to the path "images/rivers.jpg"
//let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
//  guard let metadata = metadata else {
//    // Uh-oh, an error occurred!
//    return
//  }
//  // Metadata contains file metadata such as size, content-type.
//  let size = metadata.size
//  // You can also access to download URL after upload.
//  riversRef.downloadURL { (url, error) in
//    guard let downloadURL = url else {
//      // Uh-oh, an error occurred!
//      return
//    }
//  }
//}
