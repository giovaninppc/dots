//
//  CurrentGameState.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

class EnemyController {
    
    var enemies: [Enemy] = [Enemy]()
    var timer: Timer = Timer()
    var scene: GameScene?
    var boundsWidth: CGFloat = 0
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self,
                                     selector: #selector(addEnemy), userInfo: nil, repeats: true)
        boundsWidth = UIScreen.main.bounds.size.width
    }
    
    // Create Enemy depending on the Level
    func createEnemy() -> Enemy {
        return EnemyFactory.createEnemy(with: .plane, for: (scene?.state?.currentState)!)
    }
    
    @objc func addEnemy() {
        scene?.addEnemy(createEnemy(), at: RandomPoint.getRandomStartPoint(limit: boundsWidth))
    }
    
    func getCurrentEnemies() -> [Enemy] {
        return enemies
    }
    
}

class RandomPoint {
    
    class func getRandomStartPoint(limit: CGFloat) -> CGPoint {
        let x: UInt32 = arc4random_uniform(UInt32(limit))
        let x2: Int = Int(limit/2) - Int(x)
        return CGPoint(x: CGFloat(x2), y: (UIScreen.main.bounds.size.height/2))
    }
    
}
