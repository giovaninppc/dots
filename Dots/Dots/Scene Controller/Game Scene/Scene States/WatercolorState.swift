//
//  BlueprintScene.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 15/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

class WatercolorState: GameSceneState {
    
    var currentState: GameStates = .watercolor
    
    func setEnemies(for state: GameStates, enemies: [Enemy]) {
        for enemy in enemies {
            enemy.update(for: state)
        }
    }
    
    func change(background: SKSpriteNode) {
        background.texture = SKTexture(imageNamed: "Watercolor")
    }
}
