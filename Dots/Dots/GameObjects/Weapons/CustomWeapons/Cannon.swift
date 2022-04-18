//
//  PlaneEnemy.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class CannonWeapon: Weapon, WeaponProtocol {
    var life: Int = 10
    weak var shotDelegate: ShotDelegate?

    let weaponSize: CGSize = CGSize(width: 50, height: 50)
    var fireDelay: TimeInterval = 3.0

    // Game States and positions
    // This enemy textures for each GameState
    let stateDict: [GameStates: SKTexture] = [
        .doodle: SKTexture(imageNamed: "ResourceA"),
        .blueprint: SKTexture(imageNamed: "ResourceB"),
        .watercolor: SKTexture(imageNamed: "ResourceC")
    ]

    var animation: SKAction = SKAction.run {}

    init(state: GameStates, delegate: ShotDelegate?) {
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
        animation = SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: fireDelay),
            SKAction.run { [weak self] in self?.fire() }
        ]))
    }

    func startAction() {
        self.run(animation)
    }

    func configureBody() {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        body.affectedByGravity = false
        body.allowsRotation = false
        body.collisionBitMask = PhysicsCategory.none
        body.categoryBitMask = PhysicsCategory.weapon
        self.physicsBody = body
    }
}

extension CannonWeapon {
    private func fire() {
        guard let delegate = shotDelegate else { return }
        var position = self.position
        position.y += 20
        delegate.addWeaponShot(type: .canonBall, at: position)
    }
}
