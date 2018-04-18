//
//  CurrentGameState.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

protocol EnemyControllerState {
    var controller: EnemyController? {get set}
    func controlTimers()
}

// This class is resposible for creating the enemis on the scene
// it contains the Timers, which defines when the enemies are going ot be created.
// How the creation is gois to be - is defined by the 'state'
// state - is the current enemy generator state - current level
// The global counter updates the time, and calls the state method

class EnemyController {
    
    // Timers
    var planeTimer: Timer = Timer()
    var ballonTimer: Timer = Timer()
    
    var globalTimer: Timer = Timer()
    var seconds: Int = 0
    
    // Scene
    var scene: GameScene?
    var state: EnemyControllerState?
    
    init() {
        
        // Start Global Timer
        globalTimer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                           selector: #selector(updateGlobalTimer), userInfo: nil, repeats: true)
        self.planeTimer =
            Timer.scheduledTimer(timeInterval: 1, target: self,
                                 selector: #selector(addPlane),
                                 userInfo: nil, repeats: true)
        //Start the state delegate
        state?.controller = self
    }
    
    // Create Enemy depending on the Level
    func createEnemy(type enemyType: EnemyType) -> Enemy {
        return EnemyFactory.createEnemy(with: enemyType, for: (scene?.state?.currentState)!)
    }
    
    //Update Global Timer - Defines the scene behaviour and dificult
    //increment the time counter
    //THIS is the method that vary depending on the level!!!
    @objc func updateGlobalTimer() {
        self.seconds += 1
        //state?.controlTimers()
        
        if self.seconds == 10 {
            self.planeTimer.invalidate()
            self.planeTimer =
                Timer.scheduledTimer(timeInterval: 5, target: self,
                                     selector: #selector(addPlane),
                                     userInfo: nil, repeats: true)
        }
        
        if self.seconds == 5 {
            self.ballonTimer.invalidate()
            self.ballonTimer =
                Timer.scheduledTimer(timeInterval: 15, target: self,
                                     selector: #selector(addBaloon), userInfo: nil, repeats: true)
        }
        
        if self.seconds == 120 {
            self.ballonTimer.invalidate()
            self.ballonTimer = Timer.scheduledTimer(timeInterval: 10, target: self,
                                                          selector: #selector(addBaloon), userInfo: nil, repeats: true)
        }
    }
    
    // Enemy Creators
    @objc func addPlane() {
        scene?.addEnemy(createEnemy(type: .plane))
    }
    @objc func addBaloon() {
        scene?.addEnemy(createEnemy(type: .baloon))
    }
}
