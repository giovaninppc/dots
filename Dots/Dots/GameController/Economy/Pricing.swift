//
//  Pricing.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 23/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

extension WeaponType {
    static var purchasable: [WeaponType] { allCases.filter { $0.price > 0 } }

    var price: Int {
        switch self {
        case .canon:
            return 100
        case .spikeBall:
            return 50
        default:
            return -1
        }
    }

    func icon() -> UIImage? {
        switch self {
        case .canon:
            return forState(
                doodle: Asset.resourceA.image,
                watercolor: Asset.resourceC.image,
                blueprint: Asset.resourceB.image
            )
        case .spikeBall:
            return forState(
                doodle: Asset.spikeBallDoodle.image,
                watercolor: Asset.spikeBallWatercolor1.image,
                blueprint: Asset.spikeBallBlueprint.image
            )
        case .canonBall:
            return nil
        }
    }
}
