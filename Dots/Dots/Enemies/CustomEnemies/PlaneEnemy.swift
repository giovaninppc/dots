//
//  PlaneEnemy.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

// Change these constants to alter the PlaneEnemy Behaviour
let planeDownSpeed: Double = -30.0
let planeHorizontalMove: Double = 50.0

// Plane Enemy
class PlaneEnemy: Enemy, EnemyProtocol {
    
    var enemySize: CGSize = CGSize(width: 80, height: 80)
    
    // Game States and positions
    // This enemy textures for each GameState
    let stateDict: [GameStates: SKTexture] = [
        .doodle: SKTexture(imageNamed: "doodlePlane"),
        .blueprint: SKTexture(imageNamed: "paperPlane"),
        .watercolor: SKTexture(imageNamed: "watercolorPlane")
    ]
    
    // This enemy proper Animation
    var planeAnimation: SKAction = SKAction.run {}
    
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
    }
    
    func createAction() {
        planeAnimation = SKAction.repeatForever(SKAction.sequence([
            SKAction.scaleX(to: -1, duration: 0.2),
            SKAction.move(by: CGVector(dx: planeHorizontalMove,
                                       dy: planeDownSpeed),
                          duration: 2.0+Double(arc4random_uniform(10))*0.1),
            SKAction.scaleX(to: 1, duration: 0.2),
            SKAction.move(by: CGVector(dx: -1*planeHorizontalMove,
                                       dy: planeDownSpeed),
                          duration: 2.0+Double(arc4random_uniform(10))*0.1)]))
    }
    
    /// Start enemy animation - movement
    func startAction() {
        self.run(planeAnimation)
    }
    
    /// Create the physics body for collision detection
    /// for this enemy
    func configureBody() {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
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
