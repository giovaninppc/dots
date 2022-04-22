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
        // -->  SKTexture(imageNamed: "blueprintBottom")
        let limit = SKSpriteNode(
            texture: nil,
            color: .clear,
            size: CGSize(width: UIScreen.main.bounds.width, height: 50)
        )

        limit.position = CGPoint(x: 0, y: -1 * UIScreen.main.bounds.height/2 + 20)
        let body = SKPhysicsBody(rectangleOf: CGSize(width: UIScreen.main.bounds.width, height: 10))
        body.affectedByGravity = false
        body.allowsRotation = false
        body.isDynamic = false
        body.categoryBitMask = PhysicsCategory.limit
        limit.physicsBody = body
        self.scene?.addChild(limit)
    }

    func addTopOutOfBounds() {
        let topOutOfBounds = SKSpriteNode(
            texture: nil,
            color: .clear,
            size: CGSize(width: UIScreen.main.bounds.width, height: 50)
        )

        topOutOfBounds.position = CGPoint(x: 0, y: UIScreen.main.bounds.height/2 + 20)
        let body = SKPhysicsBody(rectangleOf: CGSize(width: UIScreen.main.bounds.width, height: 10))
        body.affectedByGravity = false
        body.allowsRotation = false
        body.isDynamic = false
        body.categoryBitMask = PhysicsCategory.outOfBounds
        topOutOfBounds.physicsBody = body
        self.scene?.addChild(topOutOfBounds)
    }
}
