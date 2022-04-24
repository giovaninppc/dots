//
//  WeaponSelectorView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 17/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class WeaponSelectorView: UIView {
    private let position: CGPoint

    var onDismiss: (() -> Void)?

    enum Configuration {
        static let circleSize: CGFloat = 100.0
        static let buttonSize: CGFloat = 40.0
    }

    private let dimmer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()

    private let aim: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.aimWhite.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let attackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.attackCircle.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var attackButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.sword.image, for: .normal)
        button.addTarget(self, action: #selector(didTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(didTapOut(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(didTapOut(_:)), for: .touchUpOutside)
        return button
    }()

    private let defendImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.defendCircle.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var defendButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.shield.image, for: .normal)
        button.addTarget(self, action: #selector(didTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(didTapOut(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(didTapOut(_:)), for: .touchUpOutside)
        return button
    }()

    private let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.itemCircle.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var itemButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.item.image, for: .normal)
        button.addTarget(self, action: #selector(didTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(didTapOut(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(didTapOut(_:)), for: .touchUpOutside)
        return button
    }()

    private let weaponCarousel: WeaponCarousel = {
        let carousel = WeaponCarousel()
        carousel.isHidden = true
        return carousel
    }()

    init(position: CGPoint) {
        self.position = position
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension WeaponSelectorView: CodeView {
    func setupComponents() {
        addSubview(dimmer)
        addSubview(aim)
        addSubview(attackImage)
        addSubview(defendImage)
        addSubview(itemImage)
        addSubview(attackButton)
        addSubview(defendButton)
        addSubview(itemButton)
        addSubview(weaponCarousel)
    }

    func setupConstraints() {
        constrain {
            [
                // Dimmer
                dimmer.topAnchor.constraint(equalTo: topAnchor),
                dimmer.bottomAnchor.constraint(equalTo: bottomAnchor),
                dimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
                dimmer.trailingAnchor.constraint(equalTo: trailingAnchor),

                // Attack
                attackImage.widthAnchor.constraint(equalTo: attackImage.heightAnchor),
                attackImage.heightAnchor.constraint(equalToConstant: Configuration.circleSize),
                attackImage.centerXAnchor.constraint(equalTo: centerXAnchor),
                attackImage.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -130.0),

                attackButton.heightAnchor.constraint(equalTo: attackButton.widthAnchor),
                attackButton.widthAnchor.constraint(equalToConstant: Configuration.buttonSize),
                attackButton.centerXAnchor.constraint(equalTo: attackImage.centerXAnchor, constant: 70.0),
                attackButton.centerYAnchor.constraint(equalTo: attackImage.centerYAnchor, constant: -30.0),

                // Defend
                defendImage.widthAnchor.constraint(equalTo: defendImage.heightAnchor),
                defendImage.heightAnchor.constraint(equalToConstant: Configuration.circleSize),
                defendImage.centerXAnchor.constraint(equalTo: centerXAnchor),
                defendImage.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -130.0),

                defendButton.heightAnchor.constraint(equalTo: defendButton.widthAnchor),
                defendButton.widthAnchor.constraint(equalToConstant: Configuration.buttonSize),
                defendButton.centerXAnchor.constraint(equalTo: defendImage.centerXAnchor, constant: -70.0),
                defendButton.centerYAnchor.constraint(equalTo: defendImage.centerYAnchor, constant: -30.0),

                // Item
                itemImage.widthAnchor.constraint(equalTo: itemImage.heightAnchor),
                itemImage.heightAnchor.constraint(equalToConstant: Configuration.circleSize),
                itemImage.centerXAnchor.constraint(equalTo: centerXAnchor),
                itemImage.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -130.0),

                itemButton.heightAnchor.constraint(equalTo: itemButton.widthAnchor),
                itemButton.widthAnchor.constraint(equalToConstant: Configuration.buttonSize),
                itemButton.centerXAnchor.constraint(equalTo: itemImage.centerXAnchor),
                itemButton.centerYAnchor.constraint(equalTo: itemImage.centerYAnchor, constant: 80.0),

                // Aim
                aim.centerXAnchor.constraint(equalTo: leadingAnchor, constant: position.x),
                aim.centerYAnchor.constraint(equalTo: topAnchor, constant: position.y),
                aim.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2.0),

                weaponCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
                weaponCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
                weaponCarousel.heightAnchor.constraint(equalToConstant: 400.0),
                weaponCarousel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100.0)
            ]
        }
    }

    func setupExtra() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didDismiss))
        addGestureRecognizer(tap)
    }
}

extension WeaponSelectorView {
    @objc private func didDismiss() {
        onDismiss?()
    }

    private var buttons: [UIButton] { [attackButton, defendButton, itemButton] }

    @objc private func didTouchDown(_ button: UIButton) {
        let toAnimate: [UIView] = [button, matchImage(for: button)]
        let otherButtons = buttons.filter { !($0 === button) }
        let toReduce: [UIView] = otherButtons + otherButtons.map { matchImage(for: $0) }

        UIView.animate(withDuration: 0.1) {
            toAnimate.forEach {
                $0.transform = .identity.scaledBy(x: 1.15, y: 1.15)
                $0.alpha = 1.0
            }
        }

        UIView.animate(withDuration: 0.1) {
            toReduce.forEach {
                $0.transform = .identity.scaledBy(x: 0.9, y: 0.9)
                $0.alpha = 0.7
            }
        }

        weaponCarousel.isHidden = false
    }

    @objc private func didTapOut(_ button: UIButton) {}

    private func matchImage(for button: UIButton) -> UIView {
        if button === attackButton {
            return attackImage
        } else if button === defendButton {
            return defendImage
        } else {
            return itemImage
        }
    }
}

extension WeaponSelectorView {
    func setupPreState() {
        let items = [attackImage, attackButton, defendImage, defendButton, itemImage, itemButton]
        items.forEach { $0.transform = .identity.scaledBy(x: 0.1, y: 0.1).rotated(by: 3.0 * .pi) }
    }

    func animateIn() {
        let items = [attackImage, attackButton, defendImage, defendButton, itemImage, itemButton]
        UIView.animate(withDuration: 0.3) { items.forEach { $0.transform = .identity } }
    }

    func animateOut() {
        let items = [attackImage, attackButton, defendImage, defendButton, itemImage, itemButton]
        UIView.animate(withDuration: 0.3) {
            items.forEach { $0.transform = .identity.scaledBy(x: 0.1, y: 0.1).rotated(by: 3.0 * .pi) }
            items.forEach { $0.alpha = 0.0 }
        }
    }
}
