//
//  PlaneEnemy.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

class PlaneEnemy: Enemy, EnemyProtocol {
    
    var enemySize: CGSize = CGSize(width: 50, height: 50)
    
    //Game States and positions
    let stateDict: [GameStates: SKTexture] = [.doodle: SKTexture(imageNamed: "inkPlane"),
                                              .blueprint: SKTexture(imageNamed: "paperPlane")]
    let planeAnimation: SKAction = SKAction.sequence([SKAction.move(by: CGVector(dx: 50, dy: -10), duration: 2.3),
                                                      SKAction.move(by: CGVector(dx: -50, dy: -10), duration: 2.3)])
    
    required init (state: GameStates) {
        let texture = stateDict[state]!
        super.init(texture: texture, size: enemySize)
        startAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(for state: GameStates) {
        self.texture = stateDict[state]
    }
    
    func startAction() {
        self.run(SKAction.repeatForever(planeAnimation))
    }
    
}
