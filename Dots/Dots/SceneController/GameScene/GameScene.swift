//
//  ChangeGameScene.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class GameScene: SKScene {
    var background: SKSpriteNode!
    var enemies: [Enemy] = []
    var weapons: [Weapon] = []

    var lastTouch: CGPoint = .zero

    weak var controllerDelegate: SceneToControllerDelegate?

    // State configuration
    var state: GameSceneState?

    func configureGame() {
        setupBackgroundNode()
        self.physicsWorld.contactDelegate = self

        createLimit()
        addTopOutOfBounds()
    }

    func setupBackgroundNode() {
        guard let background = self.scene?.childNode(withName: "Background") as? SKSpriteNode else {
            fatalError("Couldnt load background as SKSpriteNode")
        }
        self.background = background
    }

    func addEnemy(_ enemy: Enemy, at position: CGPoint) {
        enemy.position = position
        self.scene?.addChild(enemy)
        enemies.append(enemy)
    }

    func addEnemy(_ enemy: Enemy) {
        self.scene?.addChild(enemy)
        enemies.append(enemy)
    }

    func cleanGame() {
        self.scene?.removeAllChildren()
        self.scene?.addChild(background)
    }

    func updateGame(for newState: GameStates) {
        self.state?.change(background: background)
        state?.update(for: (self.state?.currentState)!, updatables: enemies + weapons)
    }

    func createLimit() {
        self.scene?.addChild(Limit())
    }

    func addTopOutOfBounds() {
        self.scene?.addChild(TopOutOfBounds())
    }
}
