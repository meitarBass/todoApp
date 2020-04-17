//
//  ViewController.swift
//  todoApp
//
//  Created by Meitar Basson on 15/04/2020.
//  Copyright © 2020 Meitar Basson. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var categoryTable: UITableView!
    
    lazy var categories: [Category] = [Category]()
    var selectedCategory: Category?
    
    let data = Data()
    
    
    let alert = UIAlertController(title: "Add New Category", message: "Please enter a new category", preferredStyle: .alert)
    var image: UIImage?
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        categoryTable.delegate = self
        categoryTable.dataSource = self
        
        data.getCategoriesFromDB { (category) in
            guard let categoriesArr = category as? [Category] else { return }
            self.categories = categoriesArr
            for (index, _) in self.categories.enumerated() {
                self.data.downloadImageFromStorage(imageURL: self.categories[index].imageUrl, completion: { (img) in
                    self.categories[index].image = img
                    self.categoryTable.reloadData()
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = categoryTable.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? categoryCell {
            cell.configureCell(category: categories[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]
        performSegue(withIdentifier: "toCategoryVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("delete")
            data.deleteCategoryFromDB(categoriesArr: categories, categoryToDelete: indexPath.row) { (categoriesArray) in
                self.categories = categoriesArray
                print(self.categories)
                self.categoryTable.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let categoryVC = segue.destination as? CategoryVC {
            categoryVC.category = selectedCategory
        }
    }
    
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add New Task", style: .default) { _ in
            guard let image = self.image, let text = textField.text else {return}
            var category = Category(title: text, docuemntID: nil, imageUrl: nil, image: image)
            self.data.saveImageToStorage(category: category, image: image) { url  in
                category.imageUrl = url
                self.data.saveCategoryToDB(category: category) { documentID in
                    category.docuemntID = documentID
                }
            }
            self.categories.append(category)
            self.categoryTable.reloadData()
            textField.text = ""
        }
        
        if alert.actions.count == 0 {
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create New Category"
                textField = alertTextField
            }
            alert.addAction(action)
        }
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            self.dismiss(animated: true) {
                self.present(self.alert, animated: true, completion: nil)
            }
       }
       
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
