//
//  BlueprintScene.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 15/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

class BlueprintState: GameSceneState {
    
    func setEnemies(for scene: SKScene, enemies: [Enemy]) {
        
        for enemy in enemies {
            scene.addChild(enemy)
        }
    }
}
