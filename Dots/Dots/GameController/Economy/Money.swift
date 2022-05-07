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
    private static var pColor: UIColor = .white

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
        pColor = label.textColor
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut, .autoreverse]) {
            label.transform = .identity.scaledBy(x: 1.1, y: 1.1)
            label.textColor = .red
        } completion: { _ in
            self.restart()
        }
    }

    private static func animatePlus() {
        guard let label = moneyLabel else { return }
        pColor = label.textColor
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut, .autoreverse]) {
            label.transform = .identity.scaledBy(x: 1.1, y: 1.1)
            label.textColor = .green
        } completion: { _ in
            self.restart()
        }
    }

    private static func restart() {
        guard let label = moneyLabel else { return }
        UIView.animate(withDuration: 0.2) {
            label.transform = .identity
            label.textColor = self.pColor
        }
    }
}
