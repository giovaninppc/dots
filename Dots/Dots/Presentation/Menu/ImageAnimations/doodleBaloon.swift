//
//  doodleBaloon.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 18/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class DoodleBaloon: UIImageView {
    
    let images: [UIImage] = [#imageLiteral(resourceName: "doodleBaloon-0"), #imageLiteral(resourceName: "doodleBaloon-1"), #imageLiteral(resourceName: "doodleBaloon-2"), #imageLiteral(resourceName: "doodleBaloon-3"), #imageLiteral(resourceName: "doodleBaloon-4")]

    override func willMove(toSuperview newSuperview: UIView?) {
        startAnimation()
    }
    
    override func didMoveToSuperview() {
        self.startAnimating()
    }
    
    func startAnimation() {
        self.animationImages = images
        self.animationDuration = 0.5
    }
    
}
