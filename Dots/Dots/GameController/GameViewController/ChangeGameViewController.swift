//
//  ChangeGameViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class ChangeGameViewController: UIViewController {
    let customView: ChangeGameView
    let enemyController: EnemyController

    private var gameView: SKView { customView.gameView }
    var currentState: GameStates { gameStates[currentStatus] }
    var scene: GameScene { customView.scene }

    var draggingView: UIView?
    var isDragginng: Bool = false

    // Variables

    var gameStates: [GameStates] = [.blueprint, .doodle, .watercolor]
    var currentStatus: Int = 0

    init(
        gameView: ChangeGameView,
        enemyController: EnemyController
    ) {
        self.customView = gameView
        self.enemyController = enemyController

        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        self.view = customView
        setupViewActions()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
        customView.onPause = { [weak self] in
            self?.showPause()
        }

        customView.set(weaponDelegate: self)
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
        customView.set(state: gameStates[currentStatus])
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
}
