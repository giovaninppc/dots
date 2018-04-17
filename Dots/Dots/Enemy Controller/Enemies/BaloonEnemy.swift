//
//  PlaneEnemy.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

// Change these constants to alter the PlaneEnemy Behaviour
let baloonHorizontalSpeed: Double = 5 // the smaller the faster

// Plane Enemy
class BaloonEnemy: Enemy, EnemyProtocol {
    
    var enemySize: CGSize = CGSize(width: 100, height: 100)
    
    //Game States and positions
    // This enemy textures for each GameState
    let stateDict: [GameStates: SKTexture] = [.doodle: SKTexture(imageNamed: "doodlePlane"),
                                              .blueprint: SKTexture(imageNamed: "paperPlane"),
                                              .watercolor: SKTexture(imageNamed: "watercolorPlane")]
    
    // This enemy proper Animation
    let planeAnimation: SKAction = SKAction.sequence([
        SKAction.move(by: CGVector(dx: -1*RandomPoint.boundsWidth + 50, dy: 0),
                      duration: baloonHorizontalSpeed),
        SKAction.move(by: .zero,
                      duration: 1),
        SKAction.move(by: CGVector(dx: RandomPoint.boundsWidth, dy: 0),
                      duration: baloonHorizontalSpeed)])
    
    /// This is the importante init
    /// It will start the enmy on the current gameState
    /// and configure animation and texture
    ///
    /// - Parameter state: current GameState
    required init (state: GameStates) {
        let texture = stateDict[state]!
        super.init(texture: texture, size: enemySize)
        self.position = RandomPoint.topRightSidePoint()
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
    
    /// Start enemy animation - movement
    func startAction() {
        self.run(SKAction.repeatForever(planeAnimation))
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
    
    /// The caracter should be destroyed
    /// show animation and remove from parent
    override func selfDestruct() {
        // Make animation
        self.removeFromParent()
    }
    
}
