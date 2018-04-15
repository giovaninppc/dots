//
//  GameScene.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 15/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var background: SKNode!
    var enemies: [SKNode] = [SKNode]()
    
    // State configuration
    var state: GameSceneState?
    
    func configureGame() {
        if let state = self.state {
            state.setEnemies(for: self.scene!)
        }
        
        let square = self.childNode(withName: "squareTest")!
        square.run(SKAction.init(named: "Test")!)
        
        let sprite = SKSpriteNode(color: .green, size: CGSize(width: 5, height: 5))
        sprite.run(SKAction(named: "Test")!)
        self.scene?.addChild(sprite)
    }
    
}

protocol GameSceneState {
    func setEnemies(for scene: SKScene)
}
