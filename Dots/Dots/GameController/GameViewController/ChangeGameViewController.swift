//
//  ChangeGameViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class ChangeGameViewController: UIViewController {
    private let customView: ChangeGameView
    private let enemyController: EnemyController = EnemyController()

    private var gameView: SKView { customView.gameView }
    var currentState: GameStates { gameStates[currentStatus] }
    var scene: GameScene { customView.scene }

    // Variables

    var gameStates: [GameStates] = [.blueprint, .doodle, .watercolor]
    var currentStatus: Int = 0

    init(gameView: ChangeGameView = .init()) {
        self.customView = gameView
        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        self.view = customView
        setupViewActions()
        scene.controllerDelegate = self

        MoneyController.moneyLabel = customView.moneyLabel
        MoneyController.set()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        enemyController.scene = scene
        enemyController.play()
        scene.configureGame()
        updateSceneState()

        #if DEBUG
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        gameView.showsPhysics = true
        #endif
    }
}

// MARK: - View actions

extension ChangeGameViewController {
    private func setupViewActions() {
        customView.onSwipe = { [weak self] swipe in
            self?.makeTransition(swipe)
        }
        customView.onLongPress = { [weak self] point in
            self?.showWeaponSelector(point: point)
        }
        customView.onWeaponSelectorDismiss = { [weak self] in
            self?.scene.run(SKAction.speed(to: 1.0, duration: 0.5))
        }
        customView.onPause = { [weak self] in
            self?.showPause()
        }
        customView.onPlay = { }
    }
}

// MARK: - Transitions

extension ChangeGameViewController {
    private func makeTransition(_ swipe: Swipe) {
        switch swipe {
        case .left:
            currentStatus += 1
            if currentStatus == gameStates.count {
                currentStatus = 0
            }
            transitionLeft()
        case .right:
            currentStatus -= 1
            if currentStatus < 0 {
                currentStatus = gameStates.count - 1
            }
            transitionRight()
        }
    }

    private func transitionLeft() {
        updateSceneState()
        self.scene.updateGame(for: gameStates[currentStatus])
    }

    private func transitionRight() {
        updateSceneState()
        self.scene.updateGame(for: gameStates[currentStatus])
    }

    private func updateSceneState() {
        self.scene.state = gameStates[currentStatus].buildState()
    }
}

extension ChangeGameViewController {
    private func showPause() {
        let pause = PauseViewController { [weak self] in
            self?.customView.dismissPause()
        } onCloseGame: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }

        present(pause, animated: true, completion: nil)
    }

    private func showWeaponSelector(point: CGPoint) {
        let selector = WeaponSelectorViewController(anchor: point) { [weak self] in
            self?.scene.run(SKAction.speed(to: 1.0, duration: 0.5))
        } addWeapon: { [weak self] type in
            guard let self = self else { return }
            self.scene.addWeapon(
                WeaponFactory.createWeapon(with: type, for: self.currentState, with: self.enemyController),
                at: self.scene.lastTouch
            )
        }

        present(selector, animated: true, completion: nil)
    }
}
