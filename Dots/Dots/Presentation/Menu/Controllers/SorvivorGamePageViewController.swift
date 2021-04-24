//
//  SorvivorGamePageViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 18/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class SorvivorGamePageViewController: UIViewController {
    @IBAction func pressPlay(_ sender: Any) {
        let view = ChangeGameView()
        let gameController = ChangeGameViewController(gameView: view)

        present(gameController, animated: true)
    }
}
