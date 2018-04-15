//
//  BlueprintScene.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 15/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

class BlueprintState: GameSceneState {
    
    func setEnemies(for scene: SKScene) {
        
        let sprite = SKSpriteNode(color: .orange, size: CGSize(width: 10, height: 10))
        sprite.position = CGPoint(x: 5, y: 5)
        sprite.run(SKAction(named: "Test")!)
        scene.addChild(sprite)
    }
}
