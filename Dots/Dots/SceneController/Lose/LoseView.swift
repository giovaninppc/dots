//
//  WinView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 06/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class LoseView: UIView {
    var onContinue: (() -> Void)?

    private let dimmer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Localization.Lose.title
        label.textAlignment = .center
        label.font = .sketch(size: 40.0)
        return label
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10.0
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.7)
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        button.setTitle(Localization.Lose.continue, for: .normal)
        button.titleLabel?.font = .sketch(size: 30.0)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension LoseView: CodeView {
    func setupComponents() {
        addSubview(dimmer)
        addSubview(titleLabel)
        addSubview(continueButton)
    }

    func setupConstraints() {
        constrain {
            [
                dimmer.topAnchor.constraint(equalTo: topAnchor),
                dimmer.bottomAnchor.constraint(equalTo: bottomAnchor),
                dimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
                dimmer.trailingAnchor.constraint(equalTo: trailingAnchor),

                titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25.0),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

                continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
                continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                continueButton.widthAnchor.constraint(equalToConstant: 150.0)
            ]
        }
    }
}

extension LoseView {
    @objc private func didTapContinue() {
        onContinue?()
    }
}
