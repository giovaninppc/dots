//
//  LevelProtocol.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 19/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

//The Level protocol
protocol Level: NSObjectProtocol {
    func updateRespawnTime(for time: Int, respawnTime: inout [EnemyType: Int])
}

extension Level {
    func updateRespawnTime(for time: Int, respawnTime: inout [EnemyType: Int]) {
        // Update the respawn time - if needed
        if time == 5 {
            respawnTime[.plane] = 5
        } else if time == 60 {
            respawnTime[.baloon] = 7
        }
    }
}
