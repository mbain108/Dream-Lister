//
//  ItemCell.swift
//  Dream Lister
//
//  Created by Melissa Bain on 8/29/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
 
    func configureCell(item: Item) {
        
        titleLabel.text = item.title
        priceLabel.text = "$\(item.price)"
        descriptionLabel.text = item.details
    }
}
