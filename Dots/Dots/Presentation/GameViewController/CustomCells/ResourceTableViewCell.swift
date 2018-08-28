//
//  ResourceTableViewCell.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 28/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class ResourceTableViewCell: UITableViewCell {
    
    var resources: [GameResource] = []

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
}

extension ResourceTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resources.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameResourceCVCell", for: indexPath)
            as? GameResourceCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(resource: resources[indexPath.row])
        return cell
    }
}
