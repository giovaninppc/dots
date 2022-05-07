//
//  WeaponDefinition.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 21/04/21.
//  Copyright © 2021 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

enum WeaponType: CaseIterable {
    case canon
    case canonBall
    case spikeBall
}

protocol WeaponProtocol {
    var weaponSize: CGSize { get }
    var baseDamage: Int { get }
    var damageType: DamageType { get }

    func update(for state: GameStates)
    func startAction()
    func gotHit(by enemy: EnemyProtocol?)

    init(state: GameStates, delegate: ShotDelegate?)
}

extension WeaponProtocol {
    var baseDamage: Int { 10 }
    var damageType: DamageType { .physical }
}
