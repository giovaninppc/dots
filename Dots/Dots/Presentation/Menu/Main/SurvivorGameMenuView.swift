//
//  SurvivorGameMenuView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 10/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class SurvivorGameMenuView: UIView {
    var onPlay: (() -> Void)?
    var onSettings: (() -> Void)?

    private let background: UIImageView = {
        let view = UIImageView()
        view.image = Asset.blueprint.image
        view.contentMode = .scaleAspectFill
        return view
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = .sketch(size: 30.0)
        button.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        return button
    }()

    private let settingsButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(Asset.gear.image, for: .normal)
        button.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension SurvivorGameMenuView: CodeView {
    func setupComponents() {
        addSubview(background)
        addSubview(playButton)
        addSubview(settingsButton)
    }

    func setupConstraints() {
        constrain {
            [
                background.topAnchor.constraint(equalTo: topAnchor),
                background.bottomAnchor.constraint(equalTo: bottomAnchor),
                background.leadingAnchor.constraint(equalTo: leadingAnchor),
                background.trailingAnchor.constraint(equalTo: trailingAnchor),

                playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                playButton.centerYAnchor.constraint(equalTo: centerYAnchor),

                settingsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
                settingsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
                settingsButton.heightAnchor.constraint(equalToConstant: 35.0),
                settingsButton.widthAnchor.constraint(equalToConstant: 35.0)
            ]
        }
    }

    func setupExtra() {
        settingsButton.addGearAnimation()
    }
}

extension SurvivorGameMenuView {
    @objc private func didTapPlay() {
        onPlay?()
    }

    @objc private func didTapSettings() {
        onSettings?()
    }
}
