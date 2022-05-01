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
        default:
            return -1
        }
    }

    func icon(for state: GameStates) -> UIImage? {
        switch self {
        case .canon:
            return icon(blueprint: Asset.resourceB.image, doodle: Asset.resourceA.image, watercolor: Asset.resourceC.image, state: state)
        default:
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
