//
//  ShotHandler.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 19/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import SpriteKit

protocol ShotDelegate: AnyObject {
    func addShot(type: EnemyType, at position: CGPoint)
    func addWeaponShot(type: WeaponType, at position: CGPoint)
    func add(node: SKNode)
}
