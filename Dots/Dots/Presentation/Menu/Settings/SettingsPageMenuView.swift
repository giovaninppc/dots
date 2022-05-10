//
//  SettingsPageMenuView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 10/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class SettingsPageMenuView: UIView {
    var onClose: (() -> Void)?

    private let background: UIView = {
        let view = UIVisualEffectView(effect: UIBlurEffect.init(style: .dark))
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.Settings.title
        label.font = .sketch(size: 60.0)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(Asset.xbutton.image, for: .normal)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
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
        addSubview(closeButton)

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
                contentStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50.0),

                closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
                closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
                closeButton.heightAnchor.constraint(equalToConstant: 35.0),
                closeButton.widthAnchor.constraint(equalToConstant: 35.0)
            ]
        }
    }
}

extension SettingsPageMenuView {
    @objc private func didTapClose() {
        onClose?()
    }
}
