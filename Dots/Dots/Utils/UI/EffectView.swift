//
//  EffectView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 11/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class EffectView: UIVisualEffectView {
    private let shouldRemoveBlur: Bool = AccessibilitySettings.reduceTransparency

    private let barrier: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard shouldRemoveBlur else { return }
        contentView.addSubview(barrier)
        barrier.translatesAutoresizingMaskIntoConstraints = false
        barrier.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        barrier.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        barrier.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        barrier.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
