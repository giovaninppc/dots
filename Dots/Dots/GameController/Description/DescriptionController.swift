//
//  DescriptionConntroller.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 22/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class DescriptionController: UIViewController {
    private let customView: DescriptionView = .init()
    private let onDismiss: () -> Void

    private let initialState: GameStates
    private let weapon: Weapon?
    private let enemy: Enemy?

    init(weapon: Weapon?, enemy: Enemy?, currentState: GameStates, onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
        self.initialState = currentState

        if let type = WeaponFactory.reverse(weapon: weapon) {
            self.weapon = WeaponFactory.createWeapon(with: type, for: currentState, with: nil)
        } else { self.weapon = nil }

        if let type = EnemyFactory.reverse(enemy: enemy) {
            self.enemy = EnemyFactory.createEnemy(with: type, for: currentState)
        } else { self.enemy = nil }

        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func loadView() {
        view = customView
        customView.onDismiss = { [weak self] in self?.close() }
        if let enemy = self.enemy {
            customView.configure(enemy: enemy)
        } else if let weapon = self.weapon {
            customView.configure(weapon: weapon)
        }
        customView.set(initialState: initialState)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customView.animateIn()
    }
}

extension DescriptionController {
    func close() {
        onDismiss()
        dismiss(animated: true, completion: nil)
    }
}
