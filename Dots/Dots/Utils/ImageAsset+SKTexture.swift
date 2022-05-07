//
//  SKTexture+Extension.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 07/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

extension ImageAsset {
    public var texture: SKTexture {
        SKTexture(imageNamed: name)
    }
}
