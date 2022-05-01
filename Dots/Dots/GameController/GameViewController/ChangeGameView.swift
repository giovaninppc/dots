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
    var onPlay: (() -> Void)?
    var onWeaponSelectorDismiss: (() -> Void)?

    var isFastForward: Bool = false

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
        button.alpha = 0.7
        button.addTarget(self, action: #selector(didFastForward), for: .touchUpInside)
        return button
    }()

    let moneyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .sketch(size: 30.0)
        return label
    }()

    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 80.0, height: 80.0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        return layout
    }()

    private var isStashOpened: Bool = false
    private lazy var weaponStash: WeaponStashCarousel = WeaponStashCarousel(frame: .zero, collectionViewLayout: layout)

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

                moneyLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
                moneyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10.0),

                lifeOverlay.topAnchor.constraint(equalTo: topAnchor),
                lifeOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
                lifeOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
                lifeOverlay.bottomAnchor.constraint(equalTo: bottomAnchor),

                weaponStash.leadingAnchor.constraint(equalTo: leadingAnchor),
                weaponStash.trailingAnchor.constraint(equalTo: trailingAnchor),
                weaponStash.bottomAnchor.constraint(equalTo: bottomAnchor),
                weaponStash.heightAnchor.constraint(equalToConstant: 100.0),

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
        weaponStash.transform = .identity.translatedBy(x: 0.0, y: 100.0)
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
        scene.run(SKAction.speed(to: 0.0, duration: 0.3))
        onPause?()
    }

    @objc private func didFastForward() {
        setStash(hidden: true)
        isFastForward = !isFastForward
        scene.run(SKAction.speed(to: isFastForward ? 2.0 : 1.0, duration: 0.3))
        fastForwardButton.alpha = isFastForward ? 1.0 : 0.7
    }

    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: self)
        guard !weaponStash.frame.contains(point) else { return }
        setStash(hidden: true)
    }

    @objc private func toggleStash() {
        weaponStash.reloadData()
        isStashOpened = !isStashOpened
        let button = buildButton
        let stash = weaponStash
        let money = moneyLabel

        let isOpen = isStashOpened

        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut]) {
            button.transform = isOpen ? .identity.translatedBy(x: 0.0, y: -60.0) : .identity
            stash.transform = isOpen ? .identity : .identity.translatedBy(x: 0.0, y: 100.0)
            money.transform = isOpen ? .identity.translatedBy(x: 0.0, y: -60.0) : .identity
        } completion: { _ in }
    }
}

extension ChangeGameView {
    func dismissPause() {
        scene.run(SKAction.speed(to: 1.0, duration: 0.3))
        onPlay?()
    }

    func set(weaponDelegate: WeaponBuilderDelegate?) {
        weaponStash.weaponDelegate = weaponDelegate
    }

    func setStash(hidden: Bool) {
        isStashOpened = hidden
        toggleStash()
    }
}
