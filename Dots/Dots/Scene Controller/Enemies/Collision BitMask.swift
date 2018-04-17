//
//  Collision BitMask.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

//Collision Bit Masks
struct PhysicsCategory {
    static let none: UInt32     = 0     // 0
    static let enemy: UInt32    = 0b1   // 1
    static let limit: UInt32    = 0b10  // 2
    static let all: UInt32      = 0b1111111111
}
