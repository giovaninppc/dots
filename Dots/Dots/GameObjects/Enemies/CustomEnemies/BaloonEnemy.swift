//
//  PlaneEnemy.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

final class BaloonEnemy: Enemy, EnemyProtocol {
    let baloonHorizontalSpeed: Double = Double(Int.random(in: 4...6))
    private var life: Int = 20 {
        didSet { checkDie() }
    }

    var enemySize: CGSize = CGSize(width: 75, height: 75)

    let stateDict: [GameStates: SKTexture] = [
        .doodle: Asset.doodleBaloon.texture,
        .blueprint: Asset.blueprintBaloon.texture,
        .watercolor: random(Asset.watercolorBaloon0.texture, Asset.watercolorBaloon1.texture)
    ]

    // This enemy proper Animation
    var baloonAnimation: SKAction = SKAction.run {}

    // Var state animation
    var stateAnimation: [GameStates: SKAction] =
        [.doodle: SKAction.repeatForever(
            SKAction.animate(with: [
                Asset.doodleBaloon0.texture,
                Asset.doodleBaloon1.texture,
                Asset.doodleBaloon2.texture,
                Asset.doodleBaloon3.texture,
                Asset.doodleBaloon4.texture
            ], timePerFrame: 0.1)),
         .blueprint: SKAction.repeatForever(
            SKAction.animate(with: [
                Asset.blueprintBaloon0.texture,
                Asset.blueprintBaloon1.texture,
                Asset.blueprintBaloon2.texture,
                Asset.blueprintBaloon3.texture
            ], timePerFrame: 0.04)),
         .watercolor: SKAction.animate(with: [
                random(Asset.watercolorBaloon0.texture, Asset.watercolorBaloon1.texture)
            ], timePerFrame: 50)
        ]

    weak var shotDelegate: ShotDelegate?

    required init(state: GameStates) {
        let texture = stateDict[state]!
        super.init(texture: texture, size: enemySize)
        self.position = RandomPoint.topRightSidePoint()
        createAction()
        startAction()
        configureBody()
        runSpriteAnimaton(for: state)
    }

    init(state: GameStates, delegate: ShotDelegate?) {
        let texture = stateDict[state]!
        super.init(texture: texture, size: enemySize)
        self.position = RandomPoint.topRightSidePoint()
        self.shotDelegate = delegate
        createAction()
        startAction()
        configureBody()
        runSpriteAnimaton(for: state)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func createAction() {
        baloonAnimation = SKAction.sequence([
        SKAction.move(by: CGVector(dx: -1*RandomPoint.boundsWidth + 50, dy: 0),
        duration: baloonHorizontalSpeed + Double(arc4random_uniform(3))),
        SKAction.move(by: .zero, duration: 0.5),
        SKAction.run {
            self.dropBomb()
            },
        SKAction.move(by: .zero, duration: 0.5),
        SKAction.move(by: CGVector(dx: RandomPoint.boundsWidth, dy: 0),
        duration: baloonHorizontalSpeed + Double(arc4random_uniform(3))),
        SKAction.run {
            self.selfDestruct()
            }])
    }

    func runSpriteAnimaton(for state: GameStates) {
        self.run(stateAnimation[state]!)
    }

    override func update(for state: GameStates) {
        runSpriteAnimaton(for: state)
        self.scale(to: enemySize)
    }

    func startAction() {
        self.run(baloonAnimation)
    }

    func dropBomb() {
        if let delegate = shotDelegate {
            var position = self.position
            position.y -= 20
            delegate.addShot(type: .baloonBomb, at: position)
        }
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
        EndGameController.shared.enemyDied()
    }

    func gotHit(by weapon: WeaponProtocol?) {
        guard let weapon = weapon else { return }
        let baseDamage = weapon.baseDamage

        let multiplier: Int = weapon.damageType == .fire ? 2 : 1
        life -= baseDamage * multiplier

        if life > 0 { shake() }
    }

    private func shake() {
        run(SKAction.shake())
    }

    private func checkDie() {
        guard life <= 0 else { return }
        MoneyController.earn(value: value)
        selfDestruct()
    }
}

extension BaloonEnemy: Idle {
    func idle() {
        removeAllActions()
        run(stateAnimation[.blueprint]!)
        let idle = SKAction.repeatForever(SKAction.sequence([
            SKAction.move(by: CGVector(dx: 0.0, dy: 3.0), duration: 1.0),
            SKAction.move(by: CGVector(dx: 0.0, dy: -3.0), duration: 1.0),
            SKAction.move(by: CGVector(dx: 0.0, dy: 3.0), duration: 1.0),
            SKAction.move(by: CGVector(dx: 0.0, dy: -3.0), duration: 1.0)
        ]))
        run(idle)
    }
}

extension BaloonEnemy: Describable {
    var displayName: String { Localization.Baloon.name }
    var displayDescription: String { Localization.Baloon.description }
    var value: Int { 20 }
}
