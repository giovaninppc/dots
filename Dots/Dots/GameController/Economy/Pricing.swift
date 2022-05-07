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

    func icon(for state: GameStates) -> UIImage? {
        switch self {
        case .canon:
            return icon(
                blueprint: Asset.resourceB.image,
                doodle: Asset.resourceA.image,
                watercolor: Asset.resourceC.image,
                state: state
            )
        case .spikeBall:
            return icon(
                blueprint: Asset.spikeBall1.image,
                doodle: Asset.spikeBall1.image,
                watercolor: Asset.spikeBall1.image,
                state: state
            )
        case .canonBall:
            return nil
        }
    }

    private func icon(blueprint: UIImage?, doodle: UIImage?, watercolor: UIImage?, state: GameStates) -> UIImage? {
        switch state {
        case .blueprint:
            return blueprint
        case .watercolor:
            return watercolor
        case .doodle:
            return doodle
        }
    }
}
