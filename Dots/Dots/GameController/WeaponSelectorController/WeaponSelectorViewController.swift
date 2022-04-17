//
//  WeqponSelectorViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class WeaponSelectorViewController: UIViewController {
    private let anchor: CGPoint

    init(anchor: CGPoint) {
        self.anchor = anchor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}
