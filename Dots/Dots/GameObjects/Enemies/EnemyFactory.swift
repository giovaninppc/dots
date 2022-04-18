//
//  EnemyFactory.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

/// Allows the creation of new Enemies
class EnemyFactory: NSObject {
    
    /// Create an Enemy based on type and a gamestate
    ///
    /// - Parameters:
    ///   - identifier: the EnemyType being created
    ///   - state: the current game State - it changes the enemy behaviour
    /// - Returns: the enemy created
    class func createEnemy(with identifier: EnemyType, for state: GameStates) -> Enemy {
        switch identifier {
        case .plane:
            return PlaneEnemy(state: state)
        case .baloon:
            return BaloonEnemy(state: state)
        case .baloonBomb:
            return BaloonBomb(state: state)
        default:
            fatalError("Undefined Enemy Type")
        }
    }

    class func createEnemy(with identifier: EnemyType, for state: GameStates, with delegate: ShotDelegate) -> Enemy {
        switch identifier {
        case .plane:
            return PlaneEnemy(state: state)
        case .baloon:
            return BaloonEnemy(state: state, delegate: delegate)
        case .baloonBomb:
            return BaloonBomb(state: state)
        default:
            fatalError("Undefined Enemy Type")
        }
    }
    
}
