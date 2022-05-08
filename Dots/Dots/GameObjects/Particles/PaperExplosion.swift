//
//  PaperExplosion.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 08/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

enum PaperExplosion {
    static func build() -> SKEmitterNode? {
        guard let node = SKEmitterNode(fileNamed: "Paper.sks") else { return nil }

        let sequence = SKKeyframeSequence(keyframeValues: [
            GameStates.current == .blueprint ? UIColor.white : UIColor.black
        ], times: [
            0.0
        ])
        sequence.interpolationMode = .linear
        node.particleColorSequence = sequence

        node.run(.sequence([
            .wait(forDuration: 0.03),
            .run { node.particleBirthRate = 0.0 },
            .fadeOut(withDuration: 2.0),
            .run { node.removeFromParent() }
        ]))

        return node
    }
}
