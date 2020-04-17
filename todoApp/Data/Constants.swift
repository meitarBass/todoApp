//
//  Constants.swift
//  todoApp
//
//  Created by Meitar Basson on 16/04/2020.
//  Copyright © 2020 Meitar Basson. All rights reserved.
//

import Foundation
import Firebase

let db = Firestore.firestore()
let STORAGE = Storage.storage()

let CATEGORIES_FOLDERS_PATH = "/categories-images/"
let COMPRESSION_QUALITY : CGFloat = 0.2
let MAX_DATA_SIZE: Int64 = 1 * 1024 * 1024
