//
//  Enemy.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 15/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

enum EnemyType {
    case plane
    case none
}

class EnemyFactory: NSObject {
    
    func createEnemy(with identifier: EnemyType) -> Enemy {
        switch identifier {
        case .plane:
            return EnemyPlane()
        default:
            return Enemy()
        }
    }
    
}

/// Base Enemy Class
class Enemy: SKSpriteNode {
    
    let stateDictInc: [GameStates: UIColor] = [.doodle: .red,
                                               .blueprint: .white]
    
    init() {
        super.init(texture: nil, color: .white, size: CGSize(width: 20, height: 20))
    }
    
    init(texture: SKTexture, size: CGSize) {
        super.init(texture: texture, color: .white, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(for state: GameStates) {
        self.color = stateDictInc[state]!
    }
}


class EnemyPlane: Enemy {
    
    var enemySize: CGSize = CGSize(width: 50, height: 50)
    
    //Game States and positions
    let stateDict: [GameStates: SKTexture] = [.doodle: SKTexture(imageNamed: "inkPlane"),
                                              .blueprint: SKTexture(imageNamed: "paperPlane")]
    
    override init() {
        super.init(texture: stateDict[.blueprint]!, size: enemySize)
    }
    
    init (state: GameStates) {
        let texture = stateDict[state]!
        super.init(texture: texture, size: enemySize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(for state: GameStates) {
        self.texture = stateDict[state]
    }
    
    
}
