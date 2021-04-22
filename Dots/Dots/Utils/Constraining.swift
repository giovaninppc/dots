//
//  Constraining.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 21/04/21.
//  Copyright © 2021 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

extension UIView {
    func constrain(_ constraints: () -> [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constraints())
    }

    func setupForManualConstraining() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
