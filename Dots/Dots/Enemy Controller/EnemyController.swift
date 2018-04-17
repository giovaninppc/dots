//
//  CurrentGameState.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

class EnemyController {
    
    var timer: Timer = Timer()
    var scene: GameScene?
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self,
                                     selector: #selector(addEnemy), userInfo: nil, repeats: true)
    }
    
    // Create Enemy depending on the Level
    func createEnemy() -> Enemy {
        return EnemyFactory.createEnemy(with: .plane, for: (scene?.state?.currentState)!)
    }
    
    @objc func addEnemy() {
        scene?.addEnemy(createEnemy())
    }
    
}
