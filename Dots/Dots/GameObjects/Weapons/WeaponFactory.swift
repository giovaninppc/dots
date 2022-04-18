//
//  WeaponFactory.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

enum WeaponFactory {
    static func createWeapon(with identifier: WeaponType, for state: GameStates, with delegate: ShotDelegate) -> Weapon {
        switch identifier {
        case .canon:
            return CannonWeapon(state: state)
        }
    }
}
