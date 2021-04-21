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

// Plane Enemy
class BaloonBomb: Enemy, EnemyProtocol {
    
    var enemySize: CGSize = CGSize(width: 15, height: 15)
    
    // Game States and positions
    // This enemy textures for each GameState
    let stateDict: [GameStates: SKTexture] = [.doodle: SKTexture(imageNamed: "doodleBaloonBomb"),
                                              .blueprint: SKTexture(imageNamed: "blueprintBaloonBomb"),
                                              .watercolor: SKTexture(imageNamed: "watercolorBaloonBomb")]
    
    // This enemy proper Animation
    var baloonBombAnimation: SKAction = SKAction.run {}
    
    /// This is the importante init
    /// It will start the enmy on the current gameState
    /// and configure animation and texture
    ///
    /// - Parameter state: current GameState
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
    
    /// Change the enemy texture and behaviour
    /// depending on the current game state
    ///
    /// - Parameter state: current GameState
    override func update(for state: GameStates) {
        self.texture = stateDict[state]
        self.scale(to: enemySize)
    }
    
    func createAction() {
        baloonBombAnimation = SKAction.move(by: CGVector(dx: 0, dy: -1000.0), duration: baloonBombSpeed)
    }
    
    /// Start enemy animation - movement
    func startAction() {
        self.run(baloonBombAnimation)
    }
    
    /// Create the physics body for collision detection
    /// for this enemy
    func configureBody() {
        let body = SKPhysicsBody(circleOfRadius: enemySize.height)
        body.categoryBitMask = PhysicsCategory.enemy
        body.affectedByGravity = false
        body.allowsRotation = false
        body.contactTestBitMask = PhysicsCategory.limit
        body.collisionBitMask = PhysicsCategory.none
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
