//
//  WorldPageViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 07/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class WorldPageViewController: UIViewController, PagedController {
    private let model: WorldPageModel
    let customView: WorldPageView

    init(model: WorldPageModel) {
        self.model = model
        customView = WorldPageView()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        view = customView
        customView.collection.delegate = self
        customView.collection.dataSource = self
        customView.titleLabel.text = model.name
        customView.background.image = model.background
    }
}

extension WorldPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.levels.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorldLevelCell.identifier, for: indexPath)

        if let worldCell = cell as? WorldLevelCell {
            worldCell.configure(with: .init(
                title: model.levels[indexPath.item].name,
                color: model.color
            ))
        }

        return cell
    }
}

extension WorldPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let level = model.levels[indexPath.item]
        present(GameConfigurator.build(level: level), animated: true, completion: nil)
    }
}
