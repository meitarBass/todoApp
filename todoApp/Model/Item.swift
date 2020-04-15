//
//  Item.swift
//  todoApp
//
//  Created by Meitar Basson on 15/04/2020.
//  Copyright © 2020 Meitar Basson. All rights reserved.
//

import Foundation

struct Item {
    
    let title: String
    var wasDone: Bool = false
    
    mutating func changeCheckmarkSign() {
        wasDone = !wasDone
    }
    
}
