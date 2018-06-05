//
//  PlaneAnimation.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 18/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class PlaneAnimation: UIImageView {

    let images: [UIImage] = [#imageLiteral(resourceName: "plane1"), #imageLiteral(resourceName: "plane2"), #imageLiteral(resourceName: "plane3"), #imageLiteral(resourceName: "plane4"), #imageLiteral(resourceName: "plane5"), #imageLiteral(resourceName: "plane6"), #imageLiteral(resourceName: "plane5"), #imageLiteral(resourceName: "plane4"), #imageLiteral(resourceName: "plane3"), #imageLiteral(resourceName: "plane2")]
    
    override func willMove(toSuperview newSuperview: UIView?) {
        startAnimation()
    }
    
    override func didMoveToSuperview() {
        self.startAnimating()
    }
    
    func startAnimation() {
        self.animationImages = images
        self.animationDuration = 1.5
    }

}
