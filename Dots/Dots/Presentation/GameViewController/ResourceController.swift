//
//  ResourceController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 05/06/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

extension ChangeGameViewController {
    
    func updateResourceLabel() {
        self.resourceALabel.text = "\(resourceA)"
        self.resourceBLabel.text = "\(resourceB)"
        self.resourceCLabel.text = "\(resourceC)"
    }
    
}
