//
//  GameConfigurator.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 23/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

enum GameConfigurator {
    static func build() -> UIViewController {
        let enemyController = EnemyController()
        let view = ChangeGameView()
        let controller = ChangeGameViewController(
            gameView: view,
            enemyController: enemyController
        )

        view.scene.controllerDelegate = controller
        enemyController.scene = view.scene

        MoneyController.moneyLabel = view.moneyLabel
        MoneyController.set()

        Life.healthIndicator = view.lifeOverlay
        Life.gameView = view.gameView
        Life.set()

        return controller
    }
}