//
//  GameSpeed.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 07/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class GameSpeed {
    static let shared: GameSpeed = .init()
    private init() {}

    private var speed: Double = 1.0

    var current: Double {
        get { return speed }
        set { speed = newValue }
    }
}
