//
//  WorldPageView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 07/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class WorldPageView: UIView {
    private let background: UIImageView = {
        let view = UIImageView()
        view.image = Asset.blueprint.image
        view.contentMode = .scaleAspectFill
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sketch(size: 40.0)
        label.textColor = .white
        label.textAlignment = .center
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 60, height: 60)
        return layout
    }()

    lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.contentInset = .init(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
        collection.register(WorldLevelCell.self)
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension WorldPageView: CodeView {
    func setupComponents() {
        addSubview(background)
        addSubview(titleLabel)
        addSubview(collection)
    }

    func setupConstraints() {
        constrain {
            [
                background.topAnchor.constraint(equalTo: topAnchor),
                background.bottomAnchor.constraint(equalTo: bottomAnchor),
                background.leadingAnchor.constraint(equalTo: leadingAnchor),
                background.trailingAnchor.constraint(equalTo: trailingAnchor),

                titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),

                collection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0),
                collection.leadingAnchor.constraint(equalTo: leadingAnchor),
                collection.trailingAnchor.constraint(equalTo: trailingAnchor),
                collection.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        }
    }

    func setupExtra() {
        backgroundColor = .white
    }
}
