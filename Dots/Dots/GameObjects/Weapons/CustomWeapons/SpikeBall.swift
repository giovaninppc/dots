//
//  SpikeBalll.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 07/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class SpikeBall: Weapon, WeaponProtocol {
    var life: Int = 30
    weak var shotDelegate: ShotDelegate?

    let weaponSize: CGSize = CGSize(width: 35, height: 35)

    let stateDict: [GameStates: SKTexture] = [
        .doodle: SKTexture(
            imageNamed: Asset.spikeBallDoodle.name
        ),
        .blueprint: SKTexture(
            imageNamed: Asset.spikeBallBlueprint.name
        ),
        .watercolor: SKTexture(
            imageNamed: random(
                Asset.spikeBallWatercolor1.name,
                Asset.spikeBallWatercolor2.name,
                Asset.spikeBallWatercolor3.name
            )
        )
    ]

    var animation: SKAction = SKAction.run {}

    required init (state: GameStates, delegate: ShotDelegate?) {
        let texture = stateDict[state]!
        super.init(texture: texture, size: weaponSize)

        shotDelegate = delegate
        configureBody()
        startAction()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func update(for state: GameStates) {
        self.texture = stateDict[state]
    }

    func startAction() {
        run(SKAction.rotate(byAngle: .random(in: 0.0...3.0), duration: 0.0))
    }

    func gotHit(by enemy: EnemyProtocol?) {
        let damage = enemy?.baseDamage ?? 5
        life -= damage
        if life <= 0 { selfDestruct() }
    }

    func configureBody() {
        let body = SKPhysicsBody(circleOfRadius: weaponSize.height / 1.5)
        body.affectedByGravity = false
        body.allowsRotation = false
        body.categoryBitMask = PhysicsCategory.playerBullet
        body.collisionBitMask = PhysicsCategory.none
        body.contactTestBitMask = PhysicsCategory.weapon
        self.physicsBody = body
    }
}

extension SpikeBall: Idle {
    func idle() { removeAllActions() }
}

extension SpikeBall: Describable {
    var displayName: String { Localization.SpikeBall.name }
    var displayDescription: String { Localization.SpikeBall.description }
}
