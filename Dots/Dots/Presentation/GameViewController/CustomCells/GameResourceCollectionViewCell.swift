//
//  GameResourceCollectionViewCell.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 28/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class GameResourceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var resourceLabel: UILabel!
    @IBOutlet weak var resourceImage: UIImageView!
    
    func setup(resource: GameResource) {
        self.resourceLabel.text = resource.priceTag
        self.resourceImage.animationImages = resource.animationImages
        self.resourceImage.startAnimating()
    }
    
}
