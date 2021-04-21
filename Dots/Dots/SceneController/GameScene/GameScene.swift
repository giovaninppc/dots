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
    var aim: Aim?

    var lastTouch: CGPoint = .zero

    // State configuration
    var state: GameSceneState?

    func configureGame() {
        guard let background = self.scene?.childNode(withName: "Background") as? SKSpriteNode else {
            fatalError("Couldnt load background as SKSpriteNode")
        }

        self.background = background
        self.physicsWorld.contactDelegate = self

        // Create enemy Limit
        createLimit()
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
        state?.setEnemies(for: (self.state?.currentState)!, enemies: enemies)
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
}

extension GameScene: SKPhysicsContactDelegate {
    /// Treat collision
    ///
    /// - Parameter contact: the contact object
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = collisionType(contact)

        switch collision {
        case .enemyHitEnd:
            handleEnemyEndCollision(contact)
        case .enemyGotHitByShot:
            break
        case .enemyHitWeapon:
            break
        case .undefinedCollision:
            break
        }
    }

    private func collisionType(_ contact: SKPhysicsContact) -> CollisionType {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        switch collision {
        case PhysicsCategory.enemy | PhysicsCategory.limit:
            return .enemyHitEnd
        case PhysicsCategory.enemy | PhysicsCategory.weapon:
            return .enemyHitWeapon
        case PhysicsCategory.enemy | PhysicsCategory.playerBullet:
            return .enemyGotHitByShot
        default:
            return .undefinedCollision
        }
    }

    private func handleEnemyEndCollision(_ contact: SKPhysicsContact) {
        let enemyBody = (contact.bodyA.node as? Enemy) ?? (contact.bodyB.node as? Enemy)
        enemyBody?.reachEnd()
    }
}
