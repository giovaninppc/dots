//
//  Shake.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 08/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit
import UIKit

extension SKAction {
    static func shake(duration: Float = 1.0, amplitudeX: Int = 5, amplitudeY: Int = 1) -> SKAction {
        let numberOfShakes = duration / 0.015
        var actionsArray: [SKAction] = []
        for _ in 1...Int(numberOfShakes) {
            let ddx = CGFloat(arc4random_uniform(UInt32(amplitudeX))) - CGFloat(amplitudeX / 2)
            let ddy = CGFloat(arc4random_uniform(UInt32(amplitudeY))) - CGFloat(amplitudeY / 2)
            actionsArray.append(SKAction.move(by: .init(dx: ddx, dy: ddy), duration: 0.015))
        }
        return SKAction.sequence(actionsArray)
    }
}
