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

    let weaponSize: CGSize = CGSize(width: 80, height: 80)

    // Game States and positions
    // This enemy textures for each GameState
    let stateDict: [GameStates: SKTexture] = [
        .doodle: SKTexture(imageNamed: "ResourceA"),
        .blueprint: SKTexture(imageNamed: "ResourceB"),
        .watercolor: SKTexture(imageNamed: "ResourceC")
    ]

    var animation: SKAction = SKAction.run {}

    /// This is the importante init
    /// It will start the enmy on the current gameState
    /// and configure animation and texture
    ///
    /// - Parameter state: current GameState
    required init (state: GameStates) {
        let texture = stateDict[state]!
        super.init(texture: texture, size: weaponSize)

        createAction()
        startAction()
        configureBody()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /// Change the enemy texture and behaviour
    /// depending on the current game state
    ///
    /// - Parameter state: current GameState
    override func update(for state: GameStates) {
        self.texture = stateDict[state]
    }

    func createAction() {
        animation = SKAction.run {}
    }

    /// Start enemy animation - movement
    func startAction() {
        self.run(animation)
    }

    /// Create the physics body for collision detection
    /// for this enemy
    func configureBody() {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        body.categoryBitMask = PhysicsCategory.weapon
        body.affectedByGravity = true
        body.allowsRotation = false
        body.collisionBitMask = PhysicsCategory.limit
        self.physicsBody = body
    }

    /// Got to the end of the level
    override func reachEnd() {
        self.selfDestruct()
    }

    /// The caracter should be destroyed
    /// show animation and remove from parent
    override func selfDestruct() {
        // Make animation
        self.removeFromParent()
    }

}
