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
    static func shake(duration: Float = 0.4, amplitudeX: Int = 3, amplitudeY: Int = 1) -> SKAction {
        let numberOfShakes = duration / 0.01
        var actionsArray: [SKAction] = []
        for index in 1...Int(numberOfShakes) {
            let direction: CGFloat = index % 2 == 0 ? 1.0 : -1.0
            let ddx = direction * CGFloat(Int.random(in: 1...amplitudeX))
            let ddy = direction * CGFloat(Int.random(in: 1...amplitudeY))
            actionsArray.append(SKAction.move(by: .init(dx: ddx, dy: ddy), duration: 0.01))
        }
        return SKAction.sequence(actionsArray)
    }
}
