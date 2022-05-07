//
//  EndGameController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 02/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

protocol EndGameDelegate: AnyObject {
    func enemyDied()
}

final class EndGameController {
    static let shared = EndGameController()
    weak var delegate: EndGameDelegate?

    var isEndGame: Bool = false

    private init() {}
}

extension EndGameController {
    func startEndGame() {
        isEndGame = true
    }

    func enemyDied() {
        guard isEndGame else { return }
        delegate?.enemyDied()
    }

    func restart() {
        isEndGame = false
    }
}
