//
//  Level01.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

class Level01: EnemyControllerState {
    
    var controller: EnemyController?
    
    func controlTimers() {
        
        guard let controller = self.controller else {
            return
        }
        
        if controller.seconds == 1 {
            controller.planeTimer =
                Timer.scheduledTimer(timeInterval: 5, target: self,
                                     selector: #selector(addPlane),
                                     userInfo: nil, repeats: true)
        }
        
        if controller.seconds == 10 {
            controller.planeTimer =
                Timer.scheduledTimer(timeInterval: 2, target: self,
                                     selector: #selector(addPlane),
                                     userInfo: nil, repeats: true)
        }
        
        if controller.seconds == 20 {
            controller.ballonTimer =
                Timer.scheduledTimer(timeInterval: 7, target: self,
                                     selector: #selector(addBaloon), userInfo: nil, repeats: true)
        }
        
        if controller.seconds == 30 {
            controller.ballonTimer = Timer.scheduledTimer(timeInterval: 2, target: self,
                                                          selector: #selector(addBaloon), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func addPlane() {
        controller?.addPlane()
    }
    
    @objc func addBaloon() {
        controller?.addBaloon()
    }
}
