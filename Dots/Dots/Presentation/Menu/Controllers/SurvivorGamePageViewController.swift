//
//  SorvivorGamePageViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 18/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class SurvivorGamePageViewController: UIViewController, PagedController {
    let customView: SurvivorGameMenuView

    init(view: SurvivorGameMenuView = .init()) {
        self.customView = view
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        view = customView
        customView.onPlay = { [weak self] in
            self?.pressPlay()
        }
    }

    func pressPlay() {
        present(GameConfigurator.build(level: Level1()), animated: true)
    }
}

final class SurvivorGameMenuView: UIView {
    var onPlay: (() -> Void)?

    private let background: UIImageView = {
        let view = UIImageView()
        view.image = Asset.blueprint.image
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = .sketch(size: 30.0)
        button.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        return button
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
        playButton.setupForManualConstraining()
        addSubview(playButton)
    }

    private func setupConstraints() {
        constrainBackground()
        constrainButton()
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

    private func constrainButton() {
        constrain {
            [
                playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                playButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        }
    }

    @objc private func didTapPlay() {
        onPlay?()
    }
}
