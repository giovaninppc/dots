//
//  CurrentGameState.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit


// This class is resposible for creating the enemies on the scene
// it contains the Timers, which defines when the enemies are going ot be created.
// How the creation is gois to be - is defined by the 'state'
// state - is the current enemy generator state - current level
// The global counter updates the time, and calls the state method

final class EnemyController {
    
    // Timer
    var globalTimer: Timer = Timer()
    var seconds: Int = 0
    
    // Countdowns
    var counters: [Int] = [1, 20]
    var counterRef: [EnemyType] = [.plane, .baloon]
    var respawnTime: [EnemyType: Int] = [.plane: 1, .baloon: 10]
    
    // Scene
    var scene: GameScene?
    
    init() {
        // Start Global Timer
        globalTimer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                           selector: #selector(updateGlobalTimer), userInfo: nil, repeats: true)
    }
    
    func addEnemy(type: EnemyType) {
        scene?.addEnemy(createEnemy(type: type))
    }
    
    // Create Enemy depending on the Level
    func createEnemy(type enemyType: EnemyType) -> Enemy {
        return EnemyFactory.createEnemy(with: enemyType, for: (scene?.state?.currentState)!, with: self)
    }
    
    // Update Global Timer - Defines the scene behaviour and dificult
    // increment the time counter
    // THIS is the method that vary depending on the level!!!
    @objc func updateGlobalTimer() {
        self.seconds += 1
        
        // Update countdown time
        for index in 0..<counters.count {
            counters[index] -= 1
        }
        
        // Check if time to add Enemy - for each enemyType
        for index in 0..<counters.count where counters[index] == 0 {
            addEnemy(type: counterRef[index])
            counters[index] = respawnTime[counterRef[index]]!
        }
        
        // Update the respawn time - if needed
        if self.seconds == 5 {
            respawnTime[.plane] = 5
        } else if self.seconds == 60 {
            respawnTime[.baloon] = 7
        }
    }
}

extension EnemyController: ShotDelegate {
    func addShot(type: EnemyType, at position: CGPoint) {
        let shot = EnemyFactory.createEnemy(with: type, for: (scene?.state?.currentState)!)
        shot.position = position
        scene?.addEnemy(shot)
    }
}
