//
//  BlueprintScene.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 15/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class WatercolorState: GameSceneState {
    var currentState: GameStates = .watercolor

    func change(background: SKSpriteNode) {
        background.texture = SKTexture(imageNamed: Asset.watercolor.name)
    }
}
