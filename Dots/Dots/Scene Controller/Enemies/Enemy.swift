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
    
    init() {
        super.init(texture: nil, color: .white, size: CGSize(width: 20, height: 20))
    }
    
    init(texture: SKTexture, size: CGSize) {
        super.init(texture: texture, color: .white, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class EnemyPlane: Enemy {
    
    var enemySize: CGSize = CGSize(width: 12, height: 12)
    var enemyTexture: SKTexture = SKTexture()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
