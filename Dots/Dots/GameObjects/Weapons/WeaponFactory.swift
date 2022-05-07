//
//  WeaponFactory.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

enum WeaponFactory {
    static func createWeapon(
        with identifier: WeaponType,
        for state: GameStates,
        with delegate: ShotDelegate?
    ) -> Weapon {
        switch identifier {
        case .canon:
            return CannonWeapon(state: state, delegate: delegate)
        case .canonBall:
            return CannonBall(state: state, delegate: delegate)
        case .spikeBall:
            return SpikeBall(state: state, delegate: delegate)
        }
    }

    static func reverse(weapon: Weapon?) -> WeaponType? {
        switch weapon {
        case is CannonWeapon:
            return .canon
        case is CannonBall:
            return .canonBall
        case is SpikeBall:
            return .spikeBall
        default:
            return nil
        }
    }
}
