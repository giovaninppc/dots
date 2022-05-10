//
//  SettingsPageViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 18/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class SettingsPageViewController: UIViewController, PagedController {
    let customView: SettingsPageMenuView

    init(view: SettingsPageMenuView = .init()) {
        self.customView = view
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        view = customView
        customView.onClose = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
