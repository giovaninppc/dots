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
    
    var enemySize: CGSize = CGSize(width: 75, height: 75)
    
    //Game States and positions
    // This enemy textures for each GameState
    let stateDict: [GameStates: SKTexture] =
        [.doodle: SKTexture(imageNamed: "doodleBaloon"),
         .blueprint: SKTexture(imageNamed: "blueprintBaloon"),
         .watercolor: SKTexture(imageNamed: "watercolorBaloon\(arc4random_uniform(2))")]
    
    // This enemy proper Animation
    var baloonAnimation: SKAction = SKAction.run {}
    
    // Var state animation
    var stateAnimation: [GameStates: SKAction] =
        [.doodle: SKAction.repeatForever(
            SKAction.animate(with: [SKTexture(imageNamed: "doodleBaloon-0"),
                                    SKTexture(imageNamed: "doodleBaloon-1"),
                                    SKTexture(imageNamed: "doodleBaloon-2"),
                                    SKTexture(imageNamed: "doodleBaloon-3"),
                                    SKTexture(imageNamed: "doodleBaloon-4")], timePerFrame: 0.1)),
         .blueprint: SKAction.repeatForever(
            SKAction.animate(with: [SKTexture(imageNamed: "blueprintBaloon-0"),
                                    SKTexture(imageNamed: "blueprintBaloon-1"),
                                    SKTexture(imageNamed: "blueprintBaloon-2"),
                                    SKTexture(imageNamed: "blueprintBaloon-3")], timePerFrame: 0.04)),
         .watercolor: SKAction.animate(with: [SKTexture(imageNamed: "watercolorBaloon\(arc4random_uniform(2))")],
                                       timePerFrame: 50)]
    
    /// This is the importante init
    /// It will start the enmy on the current gameState
    /// and configure animation and texture
    ///
    /// - Parameter state: current GameState
    required init (state: GameStates) {
        let texture = stateDict[state]!
        super.init(texture: texture, size: enemySize)
        self.position = RandomPoint.topRightSidePoint()
        createAction()
        startAction()
        configureBody() //Should the baloon have a physics body?
        runSpriteAnimaton(for: state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createAction() {
        baloonAnimation = SKAction.sequence([
        SKAction.move(by: CGVector(dx: -1*RandomPoint.boundsWidth + 50, dy: 0),
        duration: baloonHorizontalSpeed + Double(arc4random_uniform(3))),
        SKAction.move(by: .zero,
        duration: 1),
        SKAction.move(by: CGVector(dx: RandomPoint.boundsWidth, dy: 0),
        duration: baloonHorizontalSpeed + Double(arc4random_uniform(3))),
        SKAction.run {
            self.selfDestruct()
            }])
    }
    
    /// Run the sprite animation of the enemy
    ///
    /// - Parameter state: the current game state
    func runSpriteAnimaton(for state: GameStates) {
        self.run(stateAnimation[state]!)
    }
    
    /// Change the enemy texture and behaviour
    /// depending on the current game state
    ///
    /// - Parameter state: current GameState
    override func update(for state: GameStates) {
        runSpriteAnimaton(for: state)
        self.scale(to: enemySize)
    }
    
    /// Start enemy animation - movement
    func startAction() {
        self.run(baloonAnimation)
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
