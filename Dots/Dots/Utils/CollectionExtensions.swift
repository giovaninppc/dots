import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionView {
    func register(_ cellClass: UICollectionViewCell.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.identifier)
    }
}
