//
//  PlaneEnemy.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

// Change these constants to alter the PlaneEnemy Behaviour
let baloonBombSpeed: Double = 6

final class BaloonBomb: Enemy, EnemyProtocol {
    var enemySize: CGSize = CGSize(width: 15, height: 15)

    let stateDict: [GameStates: SKTexture] = [
        .doodle: SKTexture(imageNamed: "doodleBaloonBomb"),
        .blueprint: SKTexture(imageNamed: "blueprintBaloonBomb"),
        .watercolor: SKTexture(imageNamed: "watercolorBaloonBomb")
    ]

    var baloonBombAnimation: SKAction = SKAction.run {}

    required init (state: GameStates) {
        let texture = stateDict[state]!
        super.init(texture: texture, size: enemySize)
        self.position = RandomPoint.topScreenPoint()
        createAction()
        startAction()
        configureBody()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func update(for state: GameStates) {
        self.texture = stateDict[state]
        self.scale(to: enemySize)
    }

    func createAction() {
        baloonBombAnimation = SKAction.move(by: CGVector(dx: 0, dy: -1000.0), duration: baloonBombSpeed)
    }

    func startAction() {
        self.run(baloonBombAnimation)
    }

    func configureBody() {
        let body = SKPhysicsBody(circleOfRadius: enemySize.height)
        body.affectedByGravity = false
        body.allowsRotation = false

        body.categoryBitMask = PhysicsCategory.enemy
        body.collisionBitMask = collisionBitMask
        body.contactTestBitMask = collisionBitMask
        self.physicsBody = body
    }

    override func selfDestruct() {
        self.removeFromParent()
    }

    func gotHit(by weapon: WeaponProtocol?) {
        selfDestruct()
    }
}

extension BaloonBomb: Idle {
    func idle() {
        removeAllActions()
    }
}

extension BaloonBomb: Describable {
    var displayName: String { Localization.BaloonBomb.name }
    var displayDescription: String { Localization.BaloonBomb.description }
}
