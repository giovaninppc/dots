//
//  CodeView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

protocol CodeView: UIView {
    func setup()
    func setupComponents()
    func setupConstraints()
    func setupMasks()
    func setupExtra()
}

extension CodeView {
    func setupExtra() {}

    func setupMasks() {
        subviews.forEach { $0.setupForManualConstraining() }
    }

    func setup() {
        setupComponents()
        setupMasks()
        setupConstraints()
        setupExtra()
    }
}
