//
//  WeaponStashCarousel.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 30/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class WeaponStashCarousel: UICollectionView {
    weak var weaponDelegate: WeaponBuilderDelegate?

    private static let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 80.0, height: 80.0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        return layout
    }()

    init() {
        super.init(frame: .zero, collectionViewLayout: WeaponStashCarousel.layout)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension WeaponStashCarousel: CodeView {
    func setupComponents() {
        register(WeaponStashCell.self)
    }

    func setupConstraints() {}

    func setupExtra() {
        delegate = self
        dataSource = self
        clipsToBounds = false
        layer.masksToBounds = false
        backgroundColor = .white
        contentInset = .init(top: 0.0, left: 30.0, bottom: 0.0, right: 30.0)
    }
}

extension WeaponStashCarousel: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        WeaponType.purchasable.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeaponStashCell.identifier,
            for: indexPath
        ) as? WeaponStashCell else { return UICollectionViewCell() }
        cell.configure(with: .init(type: WeaponType.purchasable[indexPath.item]))
        cell.delegate = weaponDelegate
        return cell
    }
}
