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
    func showEndGame()
    func showDieScreen()
}

extension ChangeGameViewController: SceneToControllerDelegate {
    func show(enemy: Enemy) {
        let desc = DescriptionController(weapon: nil, enemy: enemy, currentState: currentState) {
            self.scene.setDefaultVelocity()
        }
        present(desc, animated: true, completion: nil)
        scene.setVelocity(0.2)
    }

    func show(weapon: Weapon) {
        let desc = DescriptionController(weapon: weapon, enemy: nil, currentState: currentState) {
            self.scene.setDefaultVelocity()
        }
        present(desc, animated: true, completion: nil)
        scene.setVelocity(0.2)
    }

    func showEndGame() {
        let show: () -> Void = {
            let win = WinViewController()
            self.present(win, animated: true, completion: nil)
        }
        if let presented = presentedViewController {
            presented.dismiss(animated: false, completion: show)
        } else {
            show()
        }
        scene.setVelocity(0.5)
    }

    func showDieScreen() {
        let show: () -> Void = {
            let lose = LoseViewController()
            self.present(lose, animated: true, completion: nil)
        }
        if let presented = presentedViewController {
            presented.dismiss(animated: false, completion: show)
        } else {
            show()
        }
        scene.setVelocity(0.5)
    }
}
