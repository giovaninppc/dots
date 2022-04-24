//
//  PlaneEnemy.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class CannonBall: WeaponShot, WeaponProtocol {
    var life: Int = 10
    weak var shotDelegate: ShotDelegate?

    let weaponSize: CGSize = CGSize(width: 10, height: 10)

    let stateDict: [GameStates: SKTexture] = [
        .doodle: SKTexture(imageNamed: "ResourceA"),
        .blueprint: SKTexture(imageNamed: "ResourceB"),
        .watercolor: SKTexture(imageNamed: "ResourceC")
    ]

    var animation: SKAction = SKAction.run {}

    required init (state: GameStates, delegate: ShotDelegate?) {
        let texture = stateDict[state]!
        super.init(texture: texture, size: weaponSize)

        shotDelegate = delegate

        createAction()
        startAction()
        configureBody()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func update(for state: GameStates) {
        self.texture = stateDict[state]
    }

    func createAction() {
        animation = SKAction.move(by: CGVector(dx: 0, dy: 1000.0), duration: baloonBombSpeed)
    }

    func startAction() {
        self.run(animation)
    }

    func gotHit(by enemy: EnemyProtocol?) {
        selfDestruct()
    }

    func configureBody() {
        let body = SKPhysicsBody(rectangleOf: weaponSize)
        body.affectedByGravity = false
        body.allowsRotation = false
        body.categoryBitMask = PhysicsCategory.playerBullet
        body.collisionBitMask = collisionBitMask
        body.contactTestBitMask = contactBitMask
        self.physicsBody = body
    }
}

extension CannonBall: Idle {
    func idle() { removeAllActions() }
}

extension CannonBall: Describable {
    var displayName: String { Localization.CanonBall.name }
    var displayDescription: String { Localization.CanonBall.description }
}
