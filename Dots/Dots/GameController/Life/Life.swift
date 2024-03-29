//
//  Life.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 23/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

protocol LifeDelegate: AnyObject {
    func playerDied()
}

enum Life {
    static weak var healthIndicator: UIView?
    static weak var gameView: UIView?
    static weak var delegate: LifeDelegate?

    static var health: Int = 100

    static func damage(_ value: Int) {
        health -= value
        setHealthViewState()
        shake()

        guard health <= 0 else { return }
        delegate?.playerDied()
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
        guard let view = healthIndicator, health > -100 else { return }
        let alpha: CGFloat = 0.250 - CGFloat(health)/400.0
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn]) {
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
