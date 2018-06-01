//
//  ShotHandler.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 19/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

// This protocol let the Enemies to use this class to instantiate bullets
// or other enemies
protocol ShotDelegate: class {
    func addShot(type: EnemyType, at position: CGPoint)
}
