//
//  Limit.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 23/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit
import UIKit

final class TopOutOfBounds: SKSpriteNode {
    init() {
        super.init(texture: nil, color: .clear, size: CGSize(width: UIScreen.main.bounds.width, height: 50))
        configureBody()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureBody()
    }

    private func configureBody() {
        position = CGPoint(x: 0, y: UIScreen.main.bounds.height/2 + 20)
        let body = SKPhysicsBody(rectangleOf: CGSize(width: UIScreen.main.bounds.width, height: 10))
        body.affectedByGravity = false
        body.allowsRotation = false
        body.isDynamic = false
        body.categoryBitMask = PhysicsCategory.outOfBounds
        physicsBody = body
    }
}

let topOutOfBounds = SKSpriteNode(
    texture: nil,
    color: .clear,
    size: CGSize(width: UIScreen.main.bounds.width, height: 50)
)
