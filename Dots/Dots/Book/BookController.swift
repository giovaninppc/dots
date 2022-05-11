//
//  BookController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 11/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class BookController: UIViewController {
    private let onDismiss: (() -> Void)?
    private let customView: BookView = .init()
    private let pageController = BookPageController()

    init(onDismiss: (() -> Void)? = nil) {
        self.onDismiss = onDismiss

        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func loadView() {
        view = customView
        addChild(pageController)
        customView.setContainer(controller: pageController)

        customView.onClose = { [weak self] in
            self?.onDismiss?()
            self?.dismiss(animated: true, completion: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView.didAppear()
    }
}
