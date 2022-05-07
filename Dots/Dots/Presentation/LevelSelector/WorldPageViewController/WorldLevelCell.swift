//
//  WorldLevelCell.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 07/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class WorldLevelCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sketch(size: 25.0)
        label.textColor = .white
        label.textAlignment = .center
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension WorldLevelCell: CodeView {
    func setupComponents() {
        addSubview(titleLabel)
    }

    func setupConstraints() {
        constrain {
            [
                titleLabel.topAnchor.constraint(equalTo: topAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
            ]
        }
    }

    func setupExtra() {
        layer.cornerRadius = 4.0
    }
}

extension WorldLevelCell {
    struct ViewModel {
        let title: String
        let color: UIColor
    }

    func configure(with display: ViewModel) {
        backgroundColor = display.color
        titleLabel.text = display.title
    }
}
