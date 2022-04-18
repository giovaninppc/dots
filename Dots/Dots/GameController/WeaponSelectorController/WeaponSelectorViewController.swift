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
    private let onDismiss: () -> Void
    private let addWeapon: (WeaponType) -> Void

    private let customView: WeaponSelectorView

    init(
        anchor: CGPoint,
        onDismiss: @escaping (() -> Void),
        addWeapon: @escaping (WeaponType) -> Void
    ) {
        self.anchor = anchor
        self.onDismiss = onDismiss
        self.addWeapon = addWeapon

        customView = WeaponSelectorView(position: anchor)

        super.init(nibName: nil, bundle: nil)
        customView.onDismiss = { [weak self] in  self?.didDismiss() }
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        customView.setupPreState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView.animateIn()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        customView.animateOut()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension WeaponSelectorViewController {
    private func didDismiss() {
        // MOCK
        addWeapon(.canon)

        onDismiss()
        dismiss(animated: true, completion: nil)
    }
}
