//
//  CollisionController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 18/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = collisionType(contact)

        switch collision {
        case .enemyHitEnd:
            handleEnemyEndCollision(contact)
        case .enemyGotHit:
            handleEnemyShotCollision(contact)
        case .enemyHitWeapon:
            handleEnemyShotCollision(contact)
        case .bulletGotOutOfBounds:
            handleBulletOutOfBounds(contact)
        case .undefinedCollision:
            break
        }
    }

    private func collisionType(_ contact: SKPhysicsContact) -> CollisionType {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        switch collision {
        case PhysicsCategory.enemy | PhysicsCategory.limit:
            return .enemyHitEnd
        case PhysicsCategory.enemy | PhysicsCategory.weapon:
            return .enemyHitWeapon
        case PhysicsCategory.enemy | PhysicsCategory.playerBullet:
            return .enemyGotHit
        case PhysicsCategory.outOfBounds | PhysicsCategory.playerBullet:
            return .bulletGotOutOfBounds
        default:
            return .undefinedCollision
        }
    }
}

extension GameScene {
    private func handleEnemyEndCollision(_ contact: SKPhysicsContact) {
        let enemyBody = (contact.bodyA.node as? Enemy) ?? (contact.bodyB.node as? Enemy)
        enemyBody?.reachEnd()

        let limitBody = (contact.bodyA.node as? Limit) ?? (contact.bodyB.node as? Limit)
        limitBody?.gotHit(by: enemyBody)
    }

    private func handleEnemyShotCollision(_ contact: SKPhysicsContact) {
        let weaponBody = (contact.bodyA.node as? WeaponProtocol) ?? (contact.bodyB.node as? WeaponProtocol)
        let enemyBody = (contact.bodyA.node as? EnemyProtocol) ?? (contact.bodyB.node as? EnemyProtocol)

        enemyBody?.gotHit(by: weaponBody)
        weaponBody?.gotHit(by: enemyBody)
    }

    private func handleBulletOutOfBounds(_ contact: SKPhysicsContact) {
        let bullet = (contact.bodyA.node as? WeaponShot) ?? (contact.bodyB.node as? WeaponShot)
        bullet?.selfDestruct()
    }
}
