//
//  GameSceneProtocol.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 01/06/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

protocol GameSceneState {
    var currentState: GameStates { get }
    func update(for state: GameStates, updatables: [SceneUpdatable])
    func change(background: SKSpriteNode)
}

extension GameSceneState {
    func update(for state: GameStates, updatables: [SceneUpdatable]) {
        updatables.forEach { $0.update(for: state) }
    }
}
