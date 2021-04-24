//
//  GameView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 24/04/21.
//  Copyright © 2021 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import SpriteKit

enum Swipe: Int {
    case left = 1
    case right = -1
}

final class ChangeGameView: UIView {
    var onSwipe: ((Swipe) -> Void)?
    var onLongPress: (() -> Void)?
    var onWeaponSelectorDismiss: (() -> Void)?

    let scene: GameScene = GameScene(fileNamed: "Game.sks")!

    lazy var gameView: SKView = {
        let gameView = SKView(frame: UIScreen.main.bounds)
        gameView.presentScene(scene)
        return gameView
    }()

    let weaponSelector = WeaponSelectorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension ChangeGameView {
    private func setup() {
        setupComponents()
        setupConstraints()
        setupGestures()
    }

    private func setupComponents() {
        gameView.setupForManualConstraining()
        addSubview(gameView)
        weaponSelector.setupForManualConstraining()
        addSubview(weaponSelector)
    }

    private func setupConstraints() {
        constrainGameView()
        constrainWeaponSelector()
    }

    private func constrainGameView() {
        constrain {
            [
                gameView.topAnchor.constraint(equalTo: topAnchor),
                gameView.leadingAnchor.constraint(equalTo: leadingAnchor),
                gameView.trailingAnchor.constraint(equalTo: trailingAnchor),
                gameView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        }
    }

    private func constrainWeaponSelector() {
        constrain {
            [
                weaponSelector.topAnchor.constraint(equalTo: topAnchor),
                weaponSelector.bottomAnchor.constraint(equalTo: bottomAnchor),
                weaponSelector.leadingAnchor.constraint(equalTo: leadingAnchor),
                weaponSelector.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        }
        weaponSelector.onDismiss = { [weak self] in
            self?.onWeaponSelectorDismiss?()
        }
        weaponSelector.isHidden = true
    }

    private func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight))
        swipeRight.direction = .right
        addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
        swipeLeft.direction = .left
        addGestureRecognizer(swipeLeft)

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
        addGestureRecognizer(longPress)
    }
}

extension ChangeGameView {
    @objc private func didSwipeRight() {
        onSwipe?(.right)
    }

    @objc private func didSwipeLeft() {
        onSwipe?(.left)
    }

    @objc private func didLongPress() {
        onLongPress?()
    }
}

extension ChangeGameView {
    func showWeaponSelector() {
        bringSubviewToFront(weaponSelector)
        weaponSelector.alpha = 0
        weaponSelector.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.weaponSelector.alpha = 1
        }
        scene.run(SKAction.speed(to: 0.3, duration: 0.5))
    }

    func hideWeaponSelector() {
        UIView.animate(withDuration: 0.5) {
            self.weaponSelector.alpha = 0
        } completion: { _ in
            self.sendSubviewToBack(self.weaponSelector)
            self.weaponSelector.isHidden = false
        }
        scene.run(SKAction.speed(to: 0.3, duration: 0.5))
    }
}
