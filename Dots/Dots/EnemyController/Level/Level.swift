//
//  LevelProtocol.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 19/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

protocol Level {
    func buildPlayAction(delegate: LevelDelegate) -> SKAction
}

struct Level1: Level {
    func buildPlayAction(delegate: LevelDelegate) -> SKAction {
        SKAction.sequence([
            .wait(forDuration: 1.0),
            .run { delegate.addEnemy(type: .plane) },
            .wait(forDuration: 2.0),
            .run { delegate.addEnemy(type: .plane) },
            .run { delegate.addEnemy(type: .plane) },
            .wait(forDuration: 5.0),
            .run { delegate.addEnemy(type: .plane) },
            .run { delegate.addEnemy(type: .plane) },
            .run { delegate.addEnemy(type: .plane) },
            .wait(forDuration: 10.0),
            .run { delegate.addEnemy(type: .plane) },
            .wait(forDuration: 3.0),
            .run { delegate.addEnemy(type: .plane) },
            .run { delegate.addEnemy(type: .plane) },
            .wait(forDuration: 15.0),
            .run { delegate.addEnemy(type: .baloon) },
            .wait(forDuration: 5.0),
            .run { delegate.addEnemy(type: .plane) },
            .run { delegate.addEnemy(type: .plane) },
            .wait(forDuration: 10.0),
            .run { delegate.addEnemy(type: .baloon) },
            .run { delegate.addEnemy(type: .plane) },
            .wait(forDuration: 5.0),
            .run { delegate.addEnemy(type: .baloon) },
            .run { delegate.addEnemy(type: .baloon) },
            .wait(forDuration: 7.0),
            .run { delegate.addEnemy(type: .plane) },
            .run { delegate.addEnemy(type: .plane) },
            .run { delegate.addEnemy(type: .plane) },
            .run { delegate.addEnemy(type: .baloon) },
            .wait(forDuration: 2.0),
            .run { delegate.enableEndGame() }
        ])
    }
}
