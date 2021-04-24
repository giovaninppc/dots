//
//  Constraining.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 21/04/21.
//  Copyright © 2021 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class WeaponSelectorCell: UICollectionViewCell {
    private let imageSize: CGSize = .init(width: 150.0, height: 100.0)

    private let scene: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 6.0
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .sketch(size: 20.0)
        label.numberOfLines = 2
        label.text = "Weapon"
        return label
    }()

    private let infoButton: UIButton = {
        let button = UIButton()
        button.setTitle("?", for: .normal)
        button.titleLabel?.font = .sketch(size: 15.0)
        return button
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sketch(size: 15.0)
        label.numberOfLines = 1
        label.text = "$200"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension WeaponSelectorCell {
    private func setup() {
        setupComponents()
        setupConstraints()
    }

    private func setupComponents() {
        scene.setupForManualConstraining()
        addSubview(scene)
        nameLabel.setupForManualConstraining()
        addSubview(nameLabel)
        infoButton.setupForManualConstraining()
        addSubview(infoButton)
        priceLabel.setupForManualConstraining()
        addSubview(priceLabel)
    }

    private func setupConstraints() {
        constrainScene()
        constrainName()
        constrainInfoButton()
        constrainPrice()
    }

    private func constrainScene() {
        constrain {
            [
                scene.centerXAnchor.constraint(equalTo: centerXAnchor),
                scene.topAnchor.constraint(equalTo: topAnchor),
                scene.widthAnchor.constraint(equalToConstant: imageSize.width),
                scene.heightAnchor.constraint(equalToConstant: imageSize.height)
            ]
        }
    }

    private func constrainName() {
        constrain {
            [
                nameLabel.topAnchor.constraint(equalTo: scene.bottomAnchor, constant: 15.0),
                nameLabel.centerXAnchor.constraint(equalTo: scene.centerXAnchor)
            ]
        }
    }

    private func constrainInfoButton() {
        constrain {
            [
                infoButton.topAnchor.constraint(equalTo: scene.topAnchor, constant: 2.0),
                infoButton.trailingAnchor.constraint(equalTo: scene.trailingAnchor, constant: -2.0)
            ]
        }
    }

    private func constrainPrice() {
        constrain {
            [
                priceLabel.bottomAnchor.constraint(equalTo: scene.bottomAnchor, constant: -2.0),
                priceLabel.leadingAnchor.constraint(equalTo: scene.leadingAnchor, constant: 2.0)
            ]
        }
    }
}

extension WeaponSelectorCell {
    func configure() {}
}
