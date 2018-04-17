//
//  ChangeGameScene.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var background: SKSpriteNode!
    var enemies: [Enemy] = [Enemy]()
    
    // State configuration
    var state: GameSceneState?
    
    func configureGame() {
        
        guard let background = self.scene?.childNode(withName: "Background") as? SKSpriteNode else {
            fatalError("Couldnt load background as SKSpriteNode")
        }
        self.background = background
        
        self.physicsWorld.contactDelegate = self
        //Create enemy Limit
        createLimit()
    }
    
    func addEnemy(_ enemy: Enemy, at position: CGPoint) {
        enemy.position = position
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
        
        let limit = SKSpriteNode(color: .red, size: CGSize(width: UIScreen.main.bounds.width, height: 10))
        limit.position = CGPoint(x: 0, y: -1*UIScreen.main.bounds.height/2 + 30)
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
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        // An enemy got to the end of the level
        if collision ==  PhysicsCategory.enemy | PhysicsCategory.limit {
            
            if let bodyA = contact.bodyA.node as? Enemy {
                bodyA.selfDestruct()
            } else {
                if let bodyB = contact.bodyB.node as? Enemy {
                    bodyB.selfDestruct()
                }
            }
        }
    }
}

protocol GameSceneState {
    var currentState: GameStates { get }
    func setEnemies(for state: GameStates, enemies: [Enemy])
    func change(background: SKSpriteNode)
}
