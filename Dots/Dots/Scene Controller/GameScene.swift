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
        
        guard let background = self.scene?.childNode(withName: "Background") as? SKSpriteNode! else {
            fatalError("Couldnt load background as SKSpriteNode")
        }
        self.background = background
        
        let planeEnemy1 = EnemyFactory.createEnemy(with: .plane)
        planeEnemy1.position = CGPoint(x: 0, y: 0)
        self.addChild(planeEnemy1)
        enemies.append(planeEnemy1)
        
        let planeEnemy2 = EnemyFactory.createEnemy(with: .none)
        planeEnemy2.position = CGPoint(x: 100, y: 100)
        self.addChild(planeEnemy2)
        enemies.append(planeEnemy2)
        
    }
    
    func cleanGame() {
        self.scene?.removeAllChildren()
        self.scene?.addChild(background)
    }
    
    func updateGame(for newState: GameStates) {
        self.state?.change(background: background)
        state?.setEnemies(for: (self.state?.currentState)!, enemies: enemies)
    }
    
}

protocol GameSceneState {
    var currentState: GameStates { get }
    func setEnemies(for state: GameStates, enemies: [Enemy])
    func change(background: SKSpriteNode)
}
