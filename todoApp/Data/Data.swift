//
//  Data.swift
//  todoApp
//
//  Created by Meitar Basson on 16/04/2020.
//  Copyright © 2020 Meitar Basson. All rights reserved.
//

import Foundation
import Firebase

class Data {
    
    let storageRef = STORAGE.reference()
    var ref: DocumentReference? = nil
    
    func saveImageToStorage(category: Category, image: UIImage, completion: @escaping (_ url: String) -> Void) {
        
        // Step 1: Turn the image into Data
        guard let imageData = category.image?.jpegData(compressionQuality: COMPRESSION_QUALITY) else
        { return }
        
        // Step 2: Create an storage image reference -> A location in Firestorage for it to be stored.
        let imageRef = storageRef.child("\(CATEGORIES_FOLDERS_PATH)\(category.title).jpg")
        
        // Step 3: Set the meta data
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        // Step 4: Upload the data.
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
                debugPrint(error)
                return
            } else {
                // Step 5: Once the image is uploaded, retrieve the download URL.
                imageRef.downloadURL { (url, error) in
                    if let error = error {
                        debugPrint(error)
                    } else {
                        // Need to return the image NAME or URL
                        completion("\(url!)")
                    }
                }
            }
        }
    }
    
    func downloadImageFromStorage(imageURL: String?, completion: @escaping (UIImage?) -> Void) {
        // NEED TO FIGURE OUT HOW TO RESTORE IT FROM THE CLOSURE
        guard let url = imageURL else { return }
    
        let httpsReference = Storage.storage().reference(forURL: url)
        
        httpsReference.getData(maxSize: MAX_DATA_SIZE) { (data, error) in
            if let error = error {
                debugPrint(error)
            } else {
                let image = UIImage(data: data!)
                completion(image)
            }
        }
    }
    
    func downloadImageFromStorage(imageName: String?, completion: @escaping (UIImage?) -> Void) {
        // NEED TO FIGURE OUT HOW TO RESTORE IT FROM THE CLOSURE
        
        guard let imageName = imageName else { return }
        
        var image: UIImage? = nil
        
        let imageRef = storageRef.child("\(CATEGORIES_FOLDERS_PATH)\(imageName).jpg")
        
        imageRef.getData(maxSize: MAX_DATA_SIZE) { (data, error) in
            if let error = error {
                debugPrint(error)
            } else {
                image = UIImage(data: data!)
                completion(image)
            }
        }
    }
    
    func saveCategoryToDB(category: Category, completion: @escaping (String) -> Void) {
        ref = db.collection("users").addDocument(data: [
            "imagePath" : category.imageUrl!,
            "title" : category.title
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
                completion(self.ref!.documentID)
            }
        }
    }
    
    func saveItemToDB(item: Item) {

    }
    
    func getCategoriesFromDB(completion: @escaping ([Category?]) -> Void) {
        var categoriesArr = [Category]()
        db.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                debugPrint(err)
                return
            } else {
                guard let docs = querySnapshot?.documents else { return }
                
                for document in docs {
                    guard let imagePath = document["imagePath"] as? String , let title = document["title"] as? String else { return }
                    let category = Category(title: title, docuemntID: document.documentID, imageUrl: imagePath, image: nil)
                    categoriesArr.insert(category, at: 0)
                }
                completion(categoriesArr)
            }
        }
    }
    
    func deleteCategoryFromDB(categoriesArr: [Category],categoryToDelete index: Int ,completion: @escaping ([Category]) -> Void) {
        var categories = categoriesArr
        db.collection("users").document(categories[index].docuemntID!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                self.deleteImageFromDB(imagePath: categoriesArr[index].imageUrl!) {
                    categories.remove(at: index)
                    completion(categories)
                }
            }
        }
    }
    
    func deleteImageFromDB(imagePath: String, completion: @escaping () -> Void) {
        Storage.storage().reference(forURL: imagePath).delete { (error) in
            if let error = error {
                debugPrint(error)
            } else {
                print("Files deleted Successfuly")
            }
        }
    }
}
