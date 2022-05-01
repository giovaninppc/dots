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

    var icon: UIImage? {
        switch self {
        case .canon:
            return Asset.resourceA.image
        default:
            return nil
        }
    }
}
