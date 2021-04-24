//
//  PlaneEnemy.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class Aim: SKSpriteNode, SceneUpdatable {
    let aimSize: CGSize = CGSize(width: 2000, height: 2000)

    // Game States and positions
    // This enemy textures for each GameState
    let stateDict: [GameStates: SKTexture] = [
        .doodle: SKTexture(imageNamed: "aim-black"),
        .blueprint: SKTexture(imageNamed: "aim-white"),
        .watercolor: SKTexture(imageNamed: "aim-black")
    ]

    init(state: GameStates) {
        let texture = stateDict[state]!
        super.init(texture: texture, color: .white, size: aimSize)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func update(for state: GameStates) {
        self.texture = stateDict[state]!
    }

    func reachEnd() {
        self.selfDestruct()
    }

    func selfDestruct() {
        self.removeFromParent()
    }

}
