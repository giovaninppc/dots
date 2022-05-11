//
//  PauseViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class PauseViewController: UIViewController {
    private let onDismiss: (() -> Void)
    private let onCloseGame: (() -> Void)

    init(
        onDismiss: @escaping (() -> Void),
        onCloseGame: @escaping (() -> Void)
    ) {
        self.onDismiss = onDismiss
        self.onCloseGame = onCloseGame

        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func loadView() {
        let pauseView = PauseView()
        pauseView.onDismiss = { self.dismiss() }
        pauseView.onCloseGame = { self.closeGame() }
        pauseView.onSettings = { self.showSettings() }
        view = pauseView
    }
}

extension PauseViewController {
    private func dismiss() {
        HapticWorker(type: .selection).fire()
        self.onDismiss()
        dismiss(animated: true, completion: nil)
    }

    private func closeGame() {
        HapticWorker(type: .selection).fire()
        dismiss(animated: true) {
            self.onCloseGame()
        }
    }

    private func showSettings() {
        HapticWorker(type: .selection).fire()
        present(SettingsPageViewController(), animated: true, completion: nil)
    }
}
