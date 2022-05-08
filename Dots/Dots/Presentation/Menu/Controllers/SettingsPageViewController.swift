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
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        view = customView
    }
}

final class SettingsPageMenuView: UIView {
    private let background: UIImageView = {
        let view = UIImageView()
        view.image = Asset.watercolor.image
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.Settings.title
        label.font = .sketch(size: 60.0)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        return stack
    }()

    private lazy var vibrations: SwitchView = {
        let switchView = SwitchView(
            title: Localization.Settings.vibrations,
            state: AccessibilitySettings.vibrationsEnabled) { newValue in
                AccessibilitySettings.vibrationsEnabled = newValue
            }
        return switchView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension SettingsPageMenuView: CodeView {
    func setupComponents() {
        addSubview(background)
        addSubview(titleLabel)
        addSubview(contentStack)

        contentStack.addArrangedSubview(vibrations)
    }

    func setupConstraints() {
        constrain {
            [
                background.topAnchor.constraint(equalTo: topAnchor),
                background.bottomAnchor.constraint(equalTo: bottomAnchor),
                background.leadingAnchor.constraint(equalTo: leadingAnchor),
                background.trailingAnchor.constraint(equalTo: trailingAnchor),

                titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

                contentStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
                contentStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
                contentStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50.0)
            ]
        }
    }
}
