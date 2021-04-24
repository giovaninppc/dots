import UIKit

final class WeaponCarousel: UIView {
    var weapons: [String] = ["", "", ""]

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 160.0, height: 180.0)
        return layout
    }()

    private lazy var carousel: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.contentInset = .init(top: 0, left: 15.0, bottom: 0, right: 15.0)
        collection.register(WeaponSelectorCell.self)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension WeaponCarousel {
    private func setup() {
        setupComponents()
        setupConstraints()
        setupExtraComponents()
    }

    private func setupComponents() {
        carousel.setupForManualConstraining()
        addSubview(carousel)
    }

    private func setupConstraints() {
        constrain {
            [
                carousel.topAnchor.constraint(equalTo: topAnchor),
                carousel.bottomAnchor.constraint(equalTo: bottomAnchor),
                carousel.leadingAnchor.constraint(equalTo: leadingAnchor),
                carousel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        }
    }

    private func setupExtraComponents() {
        carousel.delegate = self
        carousel.dataSource = self
    }
}

extension WeaponCarousel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weapons.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeaponSelectorCell.identifier,
                for: indexPath
        ) as? WeaponSelectorCell else {
            return UICollectionViewCell()
        }

        return cell
    }
}
