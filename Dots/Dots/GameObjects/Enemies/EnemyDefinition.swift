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

protocol EnemyProtocol: NSObjectProtocol {
    var enemySize: CGSize { get }
    var baseDamage: Int { get }
    var damageType: DamageType { get }

    init(state: GameStates)

    func update(for state: GameStates)
    func startAction()
    func gotHit(by weapon: WeaponProtocol?)
}

extension EnemyProtocol {
    var baseDamage: Int { 10 }
    var damageType: DamageType { .physical }
}
