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

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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
        cell.configure(with: WeaponType.purchasable[indexPath.item])
        cell.delegate = weaponDelegate
        return cell
    }
}
