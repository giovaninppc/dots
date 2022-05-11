//
//  SwitchView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 23/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class SwitchView: UIView {
    private let title: String
    private let state: Bool
    private let onChange: (Bool) -> Void

    private lazy var switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.addTarget(self, action: #selector(didSwitch), for: .valueChanged)
        switchButton.isOn = state
        return switchButton
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = title
        label.font = .sketch(size: 20.0)
        return label
    }()

    init(title: String, state: Bool, onChange: @escaping (Bool) -> Void) {
        self.title = title
        self.state = state
        self.onChange = onChange
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension SwitchView: CodeView {
    func setupComponents() {
        addSubview(switchButton)
        addSubview(titleLabel)
    }

    func setupConstraints() {
        constrain {
            [
                switchButton.topAnchor.constraint(equalTo: topAnchor),
                switchButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                switchButton.trailingAnchor.constraint(equalTo: trailingAnchor),

                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
            ]
        }
    }
}

extension SwitchView {
    @objc private func didSwitch() {
        onChange(switchButton.isOn)
    }
}
