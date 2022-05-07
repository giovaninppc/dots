//
//  WinViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 06/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class WinViewController: UIViewController {
    private let customView = WinView()

    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func loadView() {
        view = customView
        customView.onContinue = { [weak self] in
            self?.onContinue()
        }
    }

    private func onContinue() {
        let top = presentingViewController
        dismiss(animated: false) {
            top?.dismiss(animated: true, completion: nil)
        }
    }
}
