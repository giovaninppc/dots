//
//  ChangeGameViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

enum GameStates {
    case doodle
    case blueprint
    case watercolor
}

final class ChangeGameViewController: UIViewController {
    // Outlets
    @IBOutlet weak var gameScene: SKView!
    @IBOutlet weak var coverImageView: UIImageView!

    // Variables
    var gameStates: [GameStates] = [.blueprint, .doodle, .watercolor]
    var currentStatus: Int = 0

    var scene: GameScene!
    var enemyController: EnemyController!

    private let weaponSelector = WeaponSelectorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initiate the GameScene
        if let scene = gameScene?.scene as? GameScene {
            scene.configureGame()
            self.scene = scene
        } else {
            fatalError("Game Scene not initialized")
        }
        updateSceneState()

        // DEBUG
        gameScene.showsFPS = true
        gameScene.showsNodeCount = true
        gameScene.showsPhysics = true

        // Initiate enemyController
        enemyController = EnemyController()
        enemyController.scene = scene

        // Add gesture to change game environment
        addSwipeGestures()
        addLongPressGesture()

        // Start labels correctly
        updateResourceLabel()

        // Additional views
        setupWeaponSelector()
    }

    /// Create animation and transition left
    func transitionLeft() {
        updateSceneState()
        self.scene.updateGame(for: gameStates[currentStatus])
    }

    /// Create animation and transition right
    func transitionRight() {
        updateSceneState()
        self.scene.updateGame(for: gameStates[currentStatus])
    }

    /// Update scene with new Game State
    func updateSceneState() {
        switch gameStates[currentStatus] {
        case .doodle:
            self.scene.state = DoodleState()
        case .blueprint:
            self.scene.state = BlueprintState()
        case .watercolor:
            self.scene.state = WatercolorState()
        }
    }

    func addSwipeGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(makeTransition(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(makeTransition(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }

    func addLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.view.addGestureRecognizer(longPress)
    }

    @objc func makeTransition(_ swipe: UISwipeGestureRecognizer) {
        if swipe.direction == .left {
            currentStatus += 1
            if currentStatus == gameStates.count {
                currentStatus = 0
            }
            transitionLeft()
        } else if swipe.direction == .right {
            currentStatus -= 1
            if currentStatus < 0 {
                currentStatus = gameStates.count - 1
            }
            transitionRight()
        }
    }

    @objc private func longPressed() {
        guard weaponSelector.isHidden == true else { return }
        scene.addAim()
        addWeaponSelector()
    }

    private func addWeaponSelector() {
        weaponSelector.alpha = 0
        weaponSelector.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.weaponSelector.alpha = 1
        }
        scene.run(SKAction.speed(to: 0.3, duration: 0.5))
    }

    private func setupWeaponSelector() {
        view.addSubview(weaponSelector)
        weaponSelector.setupForManualConstraining()
        view.constrain {
            [
                weaponSelector.topAnchor.constraint(equalTo: view.topAnchor),
                weaponSelector.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                weaponSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                weaponSelector.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        }
        weaponSelector.onDismiss = { [weak self] in
            self?.scene.removeAim()
            self?.scene.run(SKAction.speed(to: 1.0, duration: 0.5))
        }
        weaponSelector.isHidden = true
    }

    /// Take a screenshot to make the tansition
    ///
    /// - Returns: the screenshot UIImage
    func takeScreenshot() -> UIImage? {
        var screenshotImage: UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in: context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
}
