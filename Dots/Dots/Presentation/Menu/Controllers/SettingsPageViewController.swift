//
//  SettingsPageViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 18/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class SettingsPageViewController: UIViewController {
    private let customView: SettingsPageMenuView

    init(view: SettingsPageMenuView = .init()) {
        self.customView = view
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        view = customView
    }
}

final class SettingsPageMenuView: UIView {
    private let background: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Watercolor")
        view.contentMode = .scaleAspectFill
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }

    private func setup() {
        setupComponents()
        setupConstraints()
    }

    private func setupComponents() {
        background.setupForManualConstraining()
        addSubview(background)
    }

    private func setupConstraints() {
        constrainBackground()
    }

    private func constrainBackground() {
        constrain {
            [
                background.topAnchor.constraint(equalTo: topAnchor),
                background.bottomAnchor.constraint(equalTo: bottomAnchor),
                background.leadingAnchor.constraint(equalTo: leadingAnchor),
                background.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        }
    }
}
