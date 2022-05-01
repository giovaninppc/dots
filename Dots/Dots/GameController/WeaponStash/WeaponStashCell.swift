//
//  WeaponStashCell.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 30/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

protocol WeaponBuilderDelegate: AnyObject {
    func didDrop(weapon: WeaponType, from gesture: UIPanGestureRecognizer)
    func beginDrag()
    func dragCanceled()
}

extension ChangeGameViewController: WeaponBuilderDelegate {
    func didDrop(weapon: WeaponType, from gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: view)
        let offsetedPoint: CGPoint = .init(
            x: point.x - (view.frame.width / 2.0),
            y: -point.y + (view.frame.height / 2.0)
        )
        scene.addWeapon(
            WeaponFactory.createWeapon(with: weapon, for: currentState, with: self.enemyController),
            at: offsetedPoint
        )
        customView.setStash(hidden: true)
    }

    func beginDrag() {
        customView.setStash(hidden: true)
    }

    func dragCanceled() {
        customView.setStash(hidden: false)
    }
}

final class WeaponStashCell: UICollectionViewCell {
    weak var delegate: WeaponBuilderDelegate?

    private var type: WeaponType = .canon
    private var notified: Bool = false

    private let drag: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()

    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()

    private let priceTag: UILabel = {
        let label = UILabel()
        label.font = .sketch(size: 15.0)
        label.textColor = .red
        label.text = "$ XX"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension WeaponStashCell: CodeView {
    func setupComponents() {
        addSubview(image)
        addSubview(priceTag)
    }

    func setupConstraints() {
        constrain {
            [
                image.topAnchor.constraint(equalTo: topAnchor),
                image.leadingAnchor.constraint(equalTo: leadingAnchor),
                image.trailingAnchor.constraint(equalTo: trailingAnchor),

                priceTag.bottomAnchor.constraint(equalTo: bottomAnchor),
                priceTag.leadingAnchor.constraint(equalTo: leadingAnchor),
                priceTag.trailingAnchor.constraint(equalTo: trailingAnchor),
                priceTag.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10.0)
            ]
        }
    }

    func setupExtra() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        addGestureRecognizer(pan)
    }
}

extension WeaponStashCell {
    @objc private func didPan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            notified = false
            let view = (delegate as? UIViewController)?.view
            view?.addSubview(drag)
            let point = gesture.location(in: view)
            drag.frame = image.frame
            drag.center = point
        case .changed:
            notifyDragIfNeeded()
            let translation = gesture.translation(in: superview ?? self)
            drag.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        case .ended:
            delegate?.didDrop(weapon: type, from: gesture)
            drag.removeFromSuperview()
        default:
            drag.removeFromSuperview()
            delegate?.dragCanceled()
        }
    }

    private func notifyDragIfNeeded() {
        guard !notified else { return }
        notified = true
        delegate?.beginDrag()
    }
}

extension WeaponStashCell {
    func configure(with display: WeaponType) {
        self.type = display
    }
}
