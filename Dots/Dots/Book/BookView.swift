//
//  BookView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 11/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class BookView: UIView {
    var onClose: (() -> Void)?

    private let bookBase: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.bookBase.image
        return imageView
    }()

    private let container: UIView = {
        let container = UIView()
        container.clipsToBounds = true
        return container
    }()

    private let background: EffectView = {
        let background = EffectView(effect: UIBlurEffect(style: .dark))
        background.alpha = AccessibilitySettings.reduceTransparency ? 1.0 : 0.7
        return background
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(Asset.xbutton.image, for: .normal)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension BookView: CodeView {
    func setupComponents() {
        addSubview(background)
        addSubview(bookBase)
        addSubview(container)
        addSubview(closeButton)
    }

    func setupConstraints() {
        constrain {
            [
                background.topAnchor.constraint(equalTo: topAnchor),
                background.leadingAnchor.constraint(equalTo: leadingAnchor),
                background.trailingAnchor.constraint(equalTo: trailingAnchor),
                background.bottomAnchor.constraint(equalTo: bottomAnchor),

                bookBase.centerXAnchor.constraint(equalTo: centerXAnchor),
                bookBase.centerYAnchor.constraint(equalTo: centerYAnchor),
                bookBase.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
                bookBase.heightAnchor.constraint(equalTo: bookBase.widthAnchor, multiplier: 754.0/497.0),

                container.centerXAnchor.constraint(equalTo: bookBase.centerXAnchor),
                container.centerYAnchor.constraint(equalTo: bookBase.centerYAnchor, constant: 5.0),
                container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
                container.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 754.0/497.0),

                closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22.5),
                closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -22.5),
                closeButton.heightAnchor.constraint(equalToConstant: 30.0),
                closeButton.widthAnchor.constraint(equalToConstant: 30.0)
            ]
        }
    }

    func setupExtra() {
        let rotation: CGFloat = .random(in: -0.2...0.2)
        bookBase.transform = .identity.translatedBy(x: 0.0, y: 500.0).rotated(by: rotation)
        container.transform = .identity.translatedBy(x: 0.0, y: 500.0).rotated(by: rotation)
        container.alpha = 0.3
    }
}

extension BookView {
    @objc private func didTapClose() {
        willDisappear()
        onClose?()
    }

    private func willDisappear() {
        let rotation: CGFloat = .random(in: -0.2...0.2)
        UIView.animate(withDuration: .defaultAnimation, delay: 0.0, options: [.curveEaseInOut]) {
            self.bookBase.transform = .identity.translatedBy(x: 0.0, y: 500.0).rotated(by: rotation)
            self.container.transform = .identity.translatedBy(x: 0.0, y: 500.0).rotated(by: rotation)
            self.container.alpha = 0.0
            self.bookBase.alpha = 0.0
        } completion: { _ in }
    }
}

extension BookView {
    func setContainer(controller: UIViewController) {
        container.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        constrain {
            [
                controller.view.topAnchor.constraint(equalTo: container.topAnchor),
                controller.view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                controller.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
            ]
        }
    }

    func didAppear() {
        UIView.animate(withDuration: .defaultAnimation, delay: 0.0, options: [.curveEaseInOut]) {
            self.container.transform = .identity
            self.bookBase.transform = .identity
            self.container.alpha = 1.0
        } completion: { _ in }
    }
}
