//
//  Collision BitMask.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

// Collision Bit Masks
struct PhysicsCategory {
    static let none: UInt32          = 0b0000000000   // 0
    static let enemy: UInt32         = 0b0000000001   // 1
    static let limit: UInt32         = 0b0000000010   // 2
    static let playerBullet: UInt32  = 0b0000000100   // 4
    static let barrier: UInt32       = 0b0000001000   // 8
    static let weapon: UInt32        = 0b0000010000   // 16
    static let outOfBounds: UInt32   = 0b0000100000   // 32
    static let all: UInt32           = 0b1111111111   // 1024
}

enum CollisionType {
    case enemyHitEnd
    case enemyHitWeapon
    case enemyGotHit
    case bulletGotOutOfBounds

    case undefinedCollision
}
