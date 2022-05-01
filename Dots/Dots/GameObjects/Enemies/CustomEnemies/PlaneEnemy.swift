//
//  PlaneEnemy.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class PlaneEnemy: Enemy, EnemyProtocol {
    private let planeDownSpeed: Double = -Double(Int.random(in: 25...30))
    private let planeHorizontalMove: Double = Double(Int.random(in: 40...55))

    var enemySize: CGSize = CGSize(width: 80, height: 80)

    let stateDict: [GameStates: String] = [
        .doodle: Asset.doodlePlane.name,
        .blueprint: Asset.paperPlane.name,
        .watercolor: Asset.watercolorPlane.name
    ]

    // This enemy proper Animation
    var planeAnimation: SKAction = SKAction.run {}

    required init (state: GameStates) {
        let texture = SKTexture(imageNamed: stateDict[state]!)
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
        self.texture = SKTexture(imageNamed: stateDict[state]!)
    }

    func createAction() {
        planeAnimation = SKAction.repeatForever(SKAction.sequence([
            SKAction.scaleX(to: -1, duration: 0.2),
            SKAction.move(by: CGVector(dx: planeHorizontalMove,
                                       dy: planeDownSpeed),
                          duration: 2.0+Double(arc4random_uniform(10))*0.1),
            SKAction.scaleX(to: 1, duration: 0.2),
            SKAction.move(by: CGVector(dx: -1 * planeHorizontalMove,
                                       dy: planeDownSpeed),
                          duration: 2.0+Double(arc4random_uniform(10))*0.1)]))
    }

    /// Start enemy animation - movement
    func startAction() {
        self.run(planeAnimation)
    }

    func configureBody() {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        body.affectedByGravity = false
        body.allowsRotation = false

        body.categoryBitMask = PhysicsCategory.enemy
        body.collisionBitMask = collisionBitMask
        body.contactTestBitMask = collisionBitMask

        self.physicsBody = body
    }

    override func reachEnd() {
        self.selfDestruct()
    }

    override func selfDestruct() {
        self.removeFromParent()
    }

    func gotHit(by weapon: WeaponProtocol?) {
        selfDestruct()
    }
}

extension PlaneEnemy: Idle {
    func idle() {
        removeAllActions()
        let idle = SKAction.repeatForever(SKAction.sequence([
            SKAction.scaleX(to: -1, duration: 0.2),
            SKAction.move(by: CGVector(dx: 0.0, dy: 3.0), duration: 1.0),
            SKAction.move(by: CGVector(dx: 0.0, dy: -3.0), duration: 1.0),
            SKAction.move(by: CGVector(dx: 0.0, dy: 3.0), duration: 1.0),
            SKAction.move(by: CGVector(dx: 0.0, dy: -3.0), duration: 1.0),
            SKAction.scaleX(to: 1, duration: 0.2),
            SKAction.move(by: CGVector(dx: 0.0, dy: 3.0), duration: 1.0),
            SKAction.move(by: CGVector(dx: 0.0, dy: -3.0), duration: 1.0),
            SKAction.move(by: CGVector(dx: 0.0, dy: 3.0), duration: 1.0),
            SKAction.move(by: CGVector(dx: 0.0, dy: -3.0), duration: 1.0)
        ]))
        run(idle)
    }
}

extension PlaneEnemy: Describable {
    var displayName: String { Localization.PaperPlane.name }
    var displayDescription: String { Localization.PaperPlane.description }
    var value: Int { 10 }
}
