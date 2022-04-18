//
//  BlueprintScene.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 15/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class BlueprintState: GameSceneState {
    var currentState: GameStates = .blueprint
    
    func change(background: SKSpriteNode) {
        background.texture = SKTexture(imageNamed: Asset.blueprint.name)
    }
}
