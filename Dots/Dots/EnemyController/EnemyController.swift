//
//  CurrentGameState.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

protocol LevelDelegate: AnyObject {
    func addEnemy(type: EnemyType)
    func enableEndGame()
}

final class EnemyController: LevelDelegate {
    private let level: Level
    weak var scene: GameScene?

    init(level: Level) {
        self.level = level
    }

    func addEnemy(type: EnemyType) {
        scene?.addEnemy(createEnemy(type: type))
    }

    func createEnemy(type enemyType: EnemyType) -> Enemy {
        EnemyFactory.createEnemy(with: enemyType, for: GameStates.current, with: self)
    }

    func enableEndGame() {
        EndGameController.shared.startEndGame()
    }
}

extension EnemyController {
    func play() { scene?.run(level.buildPlayAction(delegate: self)) }
}

extension EnemyController: ShotDelegate {
    func add(node: SKNode) {
        scene?.addChild(node)
    }

    func addShot(type: EnemyType, at position: CGPoint) {
        let shot = EnemyFactory.createEnemy(with: type, for: GameStates.current, with: self)
        shot.position = position
        scene?.addEnemy(shot)
    }

    func addWeaponShot(type: WeaponType, at position: CGPoint) {
        let shot = WeaponFactory.createWeapon(with: type, for: GameStates.current, with: self)
        shot.position = position
        scene?.addWeapon(shot, at: position)
    }
}
