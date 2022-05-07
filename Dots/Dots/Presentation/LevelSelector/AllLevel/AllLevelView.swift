//
//  AllLevelView.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 07/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class AllLevelView: UIView {
    private let background: UIImageView = {
        let view = UIImageView()
        view.image = Asset.blueprint.image
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 400, height: 400)
        return layout
    }()

    lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.contentInset = .init(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension AllLevelView: CodeView {
    func setupComponents() {
        addSubview(background)
        addSubview(collection)
    }

    func setupConstraints() {
        constrain {
            [
                background.topAnchor.constraint(equalTo: topAnchor),
                background.bottomAnchor.constraint(equalTo: bottomAnchor),
                background.leadingAnchor.constraint(equalTo: leadingAnchor),
                background.trailingAnchor.constraint(equalTo: trailingAnchor),

                collection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
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
