//
//  EnemyFactory.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

enum EnemyFactory {

    static func createEnemy(with identifier: EnemyType, for state: GameStates) -> Enemy {
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

    static func createEnemy(with identifier: EnemyType, for state: GameStates, with delegate: ShotDelegate) -> Enemy {
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

    static func reverse(enemy: Enemy?) -> EnemyType? {
        switch enemy {
        case is PlaneEnemy:
            return .plane
        case is BaloonEnemy:
            return .baloon
        case is BaloonBomb:
            return .baloonBomb
        default:
            return nil
        }
    }
    
}
