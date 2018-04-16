//
//  CurrentGameState.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class EnemyController {
    
    var enemies: [Enemy] = [Enemy()] //[Enemy]()
    
    // Create Enemy depending on the Level
    func createEnemy() -> Enemy {
        return Enemy()
    }
    
    func getCurrentEnemies() -> [Enemy] {
        return enemies
    }
    
}
