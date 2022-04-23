//
//  Money.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 23/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

enum MoneyController {
    private static var current: Int = 200 {
        didSet {
            moneyLabel?.text = "$ \(current)"
        }
    }

    weak static var moneyLabel: UILabel?

    static func canPurchase(price: Int) -> Bool {
        price <= current
    }

    static func purchase(value: Int) {
        current -= value
        animateMinus()
    }

    static func sell(value: Int) {
        current += value
        animatePlus()
    }

    static func earn(value: Int) {
        current += value
        animatePlus()
    }

    static func set(initialAmount: Int = 200) {
        current = initialAmount
    }
}

extension MoneyController {
    private static func animateMinus() {
        guard let label = moneyLabel else { return }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut, .autoreverse]) {
            label.transform = .identity.scaledBy(x: 1.3, y: 1.2)
            label.textColor = .red
        } completion: { _ in
            label.transform = .identity
            label.textColor = .white
        }
    }

    private static func animatePlus() {
        guard let label = moneyLabel else { return }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut, .autoreverse]) {
            label.transform = .identity.scaledBy(x: 1.3, y: 1.2)
            label.textColor = .green
        } completion: { _ in
            label.transform = .identity
            label.textColor = .white
        }
    }
}
