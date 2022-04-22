//
//  DescriptionView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 22/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import SpriteKit

final class DescriptionView: UIView {
    private var index: Int = 0
    private let gameStates: [GameStates] = [.blueprint, .doodle, .watercolor]
    private var currentState: GameStates { gameStates[index] }

    var onDismiss: (() -> Void)?

    private let dimmer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        return view
    }()

    private let scene: GameScene = GameScene(fileNamed: "Game.sks")!

    private lazy var gameView: SKView = {
        let gameView = SKView(frame: UIScreen.main.bounds)
        gameView.presentScene(scene)
        gameView.layer.cornerRadius = 8.0
        gameView.layer.masksToBounds = true
        gameView.alpha = 0.0
        return gameView
    }()

    private let cornerIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.corner.image
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.0
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .sketch(size: 30.0)
        label.numberOfLines = 2
        label.alpha = 0.0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .sketch(size: 20.0)
        label.numberOfLines = 0
        label.alpha = 0.0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension DescriptionView: CodeView {
    func setupComponents() {
        addSubview(dimmer)
        addSubview(gameView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(cornerIndicator)
    }

    func setupConstraints() {
        constrain {
            [
                dimmer.topAnchor.constraint(equalTo: topAnchor),
                dimmer.bottomAnchor.constraint(equalTo: bottomAnchor),
                dimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
                dimmer.trailingAnchor.constraint(equalTo: trailingAnchor),

                nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10.0),
                nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

                gameView.widthAnchor.constraint(equalToConstant: 150.0),
                gameView.heightAnchor.constraint(equalTo: gameView.widthAnchor),
                gameView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30.0),
                gameView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30.0),

                cornerIndicator.bottomAnchor.constraint(equalTo: gameView.bottomAnchor),
                cornerIndicator.trailingAnchor.constraint(equalTo: gameView.trailingAnchor),
                cornerIndicator.widthAnchor.constraint(equalTo: cornerIndicator.heightAnchor),
                cornerIndicator.widthAnchor.constraint(equalToConstant: 10.0),

                descriptionLabel.leadingAnchor.constraint(equalTo: gameView.trailingAnchor, constant: 20.0),
                descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30.0),
                descriptionLabel.centerYAnchor.constraint(equalTo: gameView.centerYAnchor)
            ]
        }
    }

    func setupExtra() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        addGestureRecognizer(tap)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight))
        swipeRight.direction = .right
        gameView.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
        swipeLeft.direction = .left
        gameView.addGestureRecognizer(swipeLeft)
    }
}

extension DescriptionView {
    @objc private func didTapScreen() {
        onDismiss?()
    }

    @objc private func didSwipeRight() {
        index += 1
        if index >= gameStates.count { index = 0 }
        updateState()
    }

    @objc private func didSwipeLeft() {
        index -= 1
        if index < 0 { index = gameStates.count - 1 }
        updateState()
    }

    private func updateState() {
        scene.setupBackgroundNode()
        scene.state = currentState.buildState()
        scene.updateGame(for: currentState)
    }
}

extension DescriptionView {
    func animateIn() {
        UIView.transition(with: nameLabel, duration: 0.5, options: [.transitionCurlDown]) {
            self.nameLabel.alpha = 1.0
        } completion: { _ in }

        UIView.transition(with: gameView, duration: 0.5, options: [.transitionCurlDown]) {
            self.gameView.alpha = 1.0
        } completion: { _ in }

        UIView.transition(with: descriptionLabel, duration: 0.5, options: [.transitionCurlDown]) {
            self.descriptionLabel.alpha = 1.0
        } completion: { _ in }

        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut) {
            self.cornerIndicator.alpha = 1.0
        } completion: { _ in }

    }
}

extension DescriptionView {
    func set(initialState: GameStates) {
        index = gameStates.firstIndex(of: initialState) ?? 0
        updateState()
    }

    func configure(weapon: Weapon) {
        scene.addWeapon(weapon, at: .zero)

        startIdle(with: weapon)
        setupContent(describable: weapon as? Describable)
    }

    func configure(enemy: Enemy) {
        scene.addEnemy(enemy, at: .zero)

        startIdle(with: enemy)
        setupContent(describable: enemy as? Describable)
    }

    private func startIdle(with animatable: Any) {
        (animatable as? Idle)?.idle()
    }

    private func setupContent(describable: Describable?) {
        nameLabel.text = describable?.displayName
        descriptionLabel.text = describable?.displayDescription
    }
}
