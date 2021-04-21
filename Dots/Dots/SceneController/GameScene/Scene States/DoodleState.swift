//
//  SketchScene.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 15/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class DoodleState: GameSceneState {
    var currentState: GameStates = .doodle
    
    func setEnemies(for state: GameStates, enemies: [Enemy]) {
        for enemy in enemies {
            enemy.update(for: state)
        }
    }
    
    func change(background: SKSpriteNode) {
        background.texture = SKTexture(imageNamed: "Paper")
    }
}
