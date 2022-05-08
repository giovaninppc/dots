//
//  PagedController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 08/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

protocol PagedController: UIViewController {
    associatedtype CustomView: UIView

    var customView: CustomView { get }

    func set(numberOfPages: Int, position: Int, style: PageCountDisplay.Style) -> Self
}

extension PagedController {
    func set(numberOfPages: Int, position: Int, style: PageCountDisplay.Style) -> Self {
        guard !customView.subviews.contains(where: { $0 is PageCountDisplay }) else { return self }
        addPageCounter(numberOfPages: numberOfPages, position: position, style: style)
        return self
    }

    private func addPageCounter(numberOfPages: Int, position: Int, style: PageCountDisplay.Style) {
        let display = PageCountDisplay(numberOfPages: numberOfPages, position: position, style: style)
        customView.addSubview(display)
        display.translatesAutoresizingMaskIntoConstraints = false
        constrain {
            [
                display.bottomAnchor.constraint(equalTo: customView.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
                display.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
                display.heightAnchor.constraint(equalToConstant: 8.0)
            ]
        }
    }
}

final class PageCountDisplay: UIStackView {
    enum Style {
        case light, dark

        var baseColor: UIColor {
            switch self {
            case .dark:
                return .black.withAlphaComponent(0.3)
            case .light:
                return .white.withAlphaComponent(0.3)
            }
        }

        var mainColor: UIColor {
            switch self {
            case .dark:
                return .black
            case .light:
                return .white
            }
        }
    }

    private let numberOfPages: Int
    private let position: Int
    private let style: Style

    init(numberOfPages: Int, position: Int, style: Style) {
        self.numberOfPages = numberOfPages
        self.position = position
        self.style = style
        super.init(frame: .zero)
        setup()
    }

    required init(coder: NSCoder) { fatalError() }
}

extension PageCountDisplay: CodeView {
    func setupComponents() {
        for index in 0..<numberOfPages {
            let dot = dot(selected: index == position)
            addArrangedSubview(dot)
        }
    }

    func setupConstraints() {}

    func setupExtra() {
        axis = .horizontal
        spacing = 10.0
    }

    private func dot(selected: Bool) -> UIView {
        let view = UIView()
        view.backgroundColor = selected ? style.mainColor : style.baseColor
        view.layer.cornerRadius = 4.0
        constrain {
            [
                view.widthAnchor.constraint(equalToConstant: 8.0),
                view.heightAnchor.constraint(equalToConstant: 8.0)
            ]
        }
        return view
    }
}
