//
//  Life.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 23/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

enum Life {
    static weak var healthIndicator: UIView?
    static weak var gameView: UIView?

    static var health: Int = 100

    static func damage(_ value: Int) {
        health -= value
        setHealthViewState()
        shake()
    }

    static func cure(_ value: Int) {
        health += value
        health = min(100, health)
        setHealthViewState()
    }

    static func set(life: Int = 100) {
        health = life
    }
}

extension Life {
    private static func setHealthViewState() {
        guard let view = healthIndicator else { return }
        let alpha: CGFloat = 0.1 + (0.1 - CGFloat(health)/1000.0)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseInOut]) {
            view.backgroundColor = .red.withAlphaComponent(alpha)
        } completion: { _ in }
    }

    private static func shake() {
        guard let gameView = gameView else { return }
        gameView.transform = CGAffineTransform(translationX: 10, y: 0)
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
            gameView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
