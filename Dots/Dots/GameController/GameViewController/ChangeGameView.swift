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
    var onLongPress: ((CGPoint) -> Void)?
    var onPause: (() -> Void)?
    var onPlay: (() -> Void)?
    var onWeaponSelectorDismiss: (() -> Void)?

    // MARK: - Subviews

    let scene: GameScene = GameScene(fileNamed: "Game.sks")!

    lazy var gameView: SKView = {
        let gameView = SKView(frame: UIScreen.main.bounds)
        gameView.presentScene(scene)
        return gameView
    }()

    let lifeOverlay: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()

    private let pauseButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.pause.image, for: .normal)
        button.addTarget(self, action: #selector(didPause), for: .touchUpInside)
        return button
    }()

    let moneyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .sketch(size: 30.0)
        return label
    }()

    // MARK: - Init

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
        lifeOverlay.setupForManualConstraining()
        addSubview(lifeOverlay)
        pauseButton.setupForManualConstraining()
        addSubview(pauseButton)
        moneyLabel.setupForManualConstraining()
        addSubview(moneyLabel)
    }

    private func setupConstraints() {
        constrain {
            [
                gameView.topAnchor.constraint(equalTo: topAnchor),
                gameView.leadingAnchor.constraint(equalTo: leadingAnchor),
                gameView.trailingAnchor.constraint(equalTo: trailingAnchor),
                gameView.bottomAnchor.constraint(equalTo: bottomAnchor),

                pauseButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10.0),
                pauseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
                pauseButton.widthAnchor.constraint(equalToConstant: 20.0),
                pauseButton.heightAnchor.constraint(equalToConstant: 25.0),

                moneyLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
                moneyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10.0),

                lifeOverlay.topAnchor.constraint(equalTo: topAnchor),
                lifeOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
                lifeOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
                lifeOverlay.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        }
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

    @objc private func didLongPress(_ recognizer: UILongPressGestureRecognizer) {
        scene.run(SKAction.speed(to: 0.3, duration: 0.3))
        onLongPress?(recognizer.location(in: self))
    }

    @objc private func didPause() {
        scene.run(SKAction.speed(to: 0.0, duration: 0.3))
        onPause?()
    }
}

extension ChangeGameView {
    func dismissPause() {
        scene.run(SKAction.speed(to: 1.0, duration: 0.3))
        onPlay?()
    }
}
