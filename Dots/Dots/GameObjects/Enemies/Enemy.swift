//
//  Enemy.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 15/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode, SceneUpdatable {
    required init(state: GameStates, delegate: ShotDelegate?) {
        super.init(texture: nil, color: .white, size: .zero)
    }

    var collisionBitMask: UInt32 { PhysicsCategory.limit | PhysicsCategory.playerBullet | PhysicsCategory.weapon }

    let stateDictInc: [GameStates: UIColor] = [
        .doodle: .red,
        .blueprint: .white,
        .watercolor: .black
    ]

    private init() {
        super.init(texture: nil, color: .white, size: CGSize(width: 20, height: 20))
    }

    init(texture: SKTexture, size: CGSize) {
        super.init(texture: texture, color: .white, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func update(for state: GameStates) {
        self.color = stateDictInc[state]!
    }

    func reachEnd() {
        self.selfDestruct()
        EndGameController.shared.enemyDied()
    }

    func selfDestruct() {
        // Make animation
        self.removeFromParent()
    }
}
