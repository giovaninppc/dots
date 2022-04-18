//
//  WeaponShot.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 18/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

class WeaponShot: Weapon {
    var strength: Double { 1.0 }
    var type: WeaponShotType { .bullet }
    var collisionBitMask: UInt32 { PhysicsCategory.limit | PhysicsCategory.enemy }

    func hitEnemy() {
        selfDestruct()
    }
}

enum WeaponShotType {
    case bullet
}
