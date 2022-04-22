//
//  SceneToController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 22/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit
import UIKit

protocol SceneToControllerDelegate: AnyObject {
    func show(enemy: Enemy)
    func show(weapon: Weapon)
}

extension ChangeGameViewController: SceneToControllerDelegate {
    func show(enemy: Enemy) {
        let desc = DescriptionController(weapon: nil, enemy: enemy, currentState: currentState) {
            self.scene.run(.speed(to: 1.0, duration: 0.3))
        }
        present(desc, animated: true, completion: nil)
        scene.run(.speed(to: 0.1, duration: 0.3))
    }

    func show(weapon: Weapon) {
        let desc = DescriptionController(weapon: weapon, enemy: nil, currentState: currentState) {
            self.scene.run(.speed(to: 1.0, duration: 0.3))
        }
        present(desc, animated: true, completion: nil)
        scene.run(.speed(to: 0.1, duration: 0.3))
    }
}
