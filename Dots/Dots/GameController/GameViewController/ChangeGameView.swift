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
    var onPause: (() -> Void)?

    var isFastForward: Bool = false

    enum Configuration {
        static let carouselHeight: CGFloat = 100.0

        // FF
        static let ffButtonDisabledAlpha: CGFloat = 0.5
        static let fastForwardSpeed: Double = 1.5
    }

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
        button.setImage(Asset.pause.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didPause), for: .touchUpInside)
        return button
    }()

    private let fastForwardButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.fastForward.image, for: .normal)
        button.tintColor = .white
        button.alpha = Configuration.ffButtonDisabledAlpha
        button.addTarget(self, action: #selector(didFastForward), for: .touchUpInside)
        return button
    }()

    let moneyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .sketch(size: 25.0)
        return label
    }()

    private var isStashOpened: Bool = false
    private lazy var weaponStash: WeaponStashCarousel = WeaponStashCarousel()

    private lazy var buildButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(toggleStash), for: .touchUpInside)
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension ChangeGameView: CodeView {
    func setupComponents() {
        addSubview(gameView)
        addSubview(lifeOverlay)
        addSubview(pauseButton)
        addSubview(fastForwardButton)
        addSubview(moneyLabel)
        addSubview(buildButton)
        addSubview(weaponStash)
    }

    func setupConstraints() {
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

                fastForwardButton.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 20.0),
                fastForwardButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
                fastForwardButton.widthAnchor.constraint(equalToConstant: 25.0),
                fastForwardButton.heightAnchor.constraint(equalToConstant: 20.0),

                moneyLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10.0),
                moneyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10.0),

                lifeOverlay.topAnchor.constraint(equalTo: topAnchor),
                lifeOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
                lifeOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
                lifeOverlay.bottomAnchor.constraint(equalTo: bottomAnchor),

                weaponStash.leadingAnchor.constraint(equalTo: leadingAnchor),
                weaponStash.trailingAnchor.constraint(equalTo: trailingAnchor),
                weaponStash.bottomAnchor.constraint(equalTo: bottomAnchor),
                weaponStash.heightAnchor.constraint(equalToConstant: Configuration.carouselHeight),

                buildButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                buildButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30.0),
                buildButton.widthAnchor.constraint(equalToConstant: 40.0),
                buildButton.heightAnchor.constraint(equalToConstant: 80.0)
            ]
        }
    }

    func setupExtra() {
        setupGestures()
        setupStashOpening()
    }

    private func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight))
        swipeRight.direction = .right
        addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
        swipeLeft.direction = .left
        addGestureRecognizer(swipeLeft)

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        addGestureRecognizer(tap)
    }

    private func setupStashOpening() {
        weaponStash.transform = .identity.translatedBy(x: 0.0, y: Configuration.carouselHeight)
    }
}

extension ChangeGameView {
    @objc private func didSwipeRight() {
        setStash(hidden: true)
        onSwipe?(.right)
    }

    @objc private func didSwipeLeft() {
        setStash(hidden: true)
        onSwipe?(.left)
    }

    @objc private func didPause() {
        setStash(hidden: true)
        scene.setVelocity(0.0)
        onPause?()
    }

    @objc private func didFastForward() {
        setStash(hidden: true)
        isFastForward = !isFastForward
        GameSpeed.shared.current = isFastForward ? Configuration.fastForwardSpeed : .one
        scene.setDefaultVelocity()
        fastForwardButton.alpha = isFastForward ? .one : Configuration.ffButtonDisabledAlpha
    }

    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: self)
        guard !weaponStash.frame.contains(point) else { return }
        setStash(hidden: true)
    }

    @objc private func toggleStash() {
        weaponStash.state = scene.state?.currentState ?? .blueprint
        weaponStash.reloadData()
        isStashOpened = !isStashOpened
        let button = buildButton
        let stash = weaponStash

        let isOpen = isStashOpened

        UIView.animate(withDuration: .defaultAnimation, delay: 0.0, options: [.curveEaseInOut]) {
            button.transform = isOpen ? .identity.translatedBy(x: 0.0, y: -60.0) : .identity
            stash.transform = isOpen ? .identity : .identity.translatedBy(x: 0.0, y: Configuration.carouselHeight)
        } completion: { _ in }
    }
}

extension ChangeGameView {
    func dismissPause() {
        scene.setDefaultVelocity()
    }

    func set(weaponDelegate: WeaponBuilderDelegate?) {
        weaponStash.weaponDelegate = weaponDelegate
    }

    func setStash(hidden: Bool) {
        isStashOpened = hidden
        toggleStash()
    }

    func set(state: GameStates) {
        UIView.animate(withDuration: .defaultAnimation) {
            switch state {
            case .watercolor, .doodle:
                self.pauseButton.tintColor = .black
                self.fastForwardButton.tintColor = .black
                self.moneyLabel.textColor = .black
            case .blueprint:
                self.pauseButton.tintColor = .white
                self.fastForwardButton.tintColor = .white
                self.moneyLabel.textColor = .white
            }
        }
    }
}
