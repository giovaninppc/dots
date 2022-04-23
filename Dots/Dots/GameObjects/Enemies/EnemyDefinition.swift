//
//  EnemyDefinition.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

enum EnemyType {
    case plane
    case baloon
    case baloonBomb
    case none
}

// This protocol only helps to create better custom Enemy classes
// the enemies have to extend the base Enemy class and the protocol for necessary behavior
protocol EnemyProtocol: NSObjectProtocol {

    var enemySize: CGSize { get }
    init(state: GameStates)
    func update(for state: GameStates)
    func startAction()
}
