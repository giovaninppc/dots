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

    private let pauseButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.pause.image, for: .normal)
        button.addTarget(self, action: #selector(didPause), for: .touchUpInside)
        return button
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
        pauseButton.setupForManualConstraining()
        addSubview(pauseButton)
    }

    private func setupConstraints() {
        constrainGameView()
        constrainPauseButton()
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

    private func constrainPauseButton() {
        constrain {
            [
                pauseButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10.0),
                pauseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
                pauseButton.widthAnchor.constraint(equalToConstant: 20.0),
                pauseButton.heightAnchor.constraint(equalToConstant: 25.0)
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
