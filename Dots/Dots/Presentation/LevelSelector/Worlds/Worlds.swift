//
//  Worlds.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 07/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

struct WorldPageModel {
    let background: UIImage
    let levels: [Level]
    let color: UIColor
    let name: String

    static var tutorial: WorldPageModel {
        .init(background: Asset.blueprint.image, levels: [Level1()], color: Asset.tutorialBlue.color, name: "Tutorial")
    }
}
