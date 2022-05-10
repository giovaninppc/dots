//
//  SplashController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 24/04/21.
//  Copyright © 2021 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation
import UIKit

final class SplashController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loadGame()
        }
    }

    private func loadGame() {
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = loadMenu()
    }

    private func loadMenu() -> UIViewController {
        let viewController = SurvivorGamePageViewController()
        return viewController
    }
}
