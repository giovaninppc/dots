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
}

protocol WeaponProtocol {
    var weaponSize: CGSize { get }

    func update(for state: GameStates)
    func startAction()

    init(state: GameStates, delegate: ShotDelegate?)
}
