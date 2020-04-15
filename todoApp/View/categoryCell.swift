//
//  categoryCell.swift
//  todoApp
//
//  Created by Meitar Basson on 15/04/2020.
//  Copyright © 2020 Meitar Basson. All rights reserved.
//

import UIKit

class categoryCell: UITableViewCell {

    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(category: Category) {
        if let image = category.image {
            cellImage.image = image
        }
        cellLabel.text = category.title
    }

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        print("Add button pressed")
    }
    
    
}
