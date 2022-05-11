//
//  SorvivorGamePageViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 18/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import GameKit
import UIKit

final class SurvivorGamePageViewController: UIViewController, PagedController {
    let customView: SurvivorGameMenuView

    init(view: SurvivorGameMenuView = .init()) {
        self.customView = view
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        view = customView
        customView.onPlay = { [weak self] in
            self?.pressPlay()
        }
        customView.onSettings = { [weak self] in
            self?.pressSettings()
            self?.hideGameCenter()
        }
        customView.onNote = { [weak self] in
            self?.showNotes()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        AchievementController.shared.authenticatePlayer(from: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addGameCenterAccessPointIfPossible()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideGameCenter()
    }

    private func pressPlay() {
        HapticWorker(type: .selection).fire()
        present(GameConfigurator.build(level: Level1()), animated: true)
//        present(LevelSelectorViewController(), animated: true, completion: nil)
        hideGameCenter()
    }

    private func pressSettings() {
        HapticWorker(type: .selection).fire()
        let settings = SettingsPageViewController { self.addGameCenterAccessPointIfPossible() }
        present(settings, animated: true, completion: nil)
    }

    private func showNotes() {
        HapticWorker(type: .selection).fire()
        let notes = BookController { self.addGameCenterAccessPointIfPossible() }
        present(notes, animated: true, completion: nil)
        hideGameCenter()
    }
}

extension SurvivorGamePageViewController {
    private func requestGameCenterAuthenticationIfNeeded() {
        AchievementController.shared.authenticatePlayer(from: self)
    }

    private func addGameCenterAccessPointIfPossible() {
        if #available(iOS 14.0, *) {
            GKAccessPoint.shared.location = .bottomLeading
            GKAccessPoint.shared.showHighlights = true
            GKAccessPoint.shared.isActive = true
        }
    }

    private func hideGameCenter() {
        if #available(iOS 14.0, *) {
            GKAccessPoint.shared.isActive = false
        }
    }
}
