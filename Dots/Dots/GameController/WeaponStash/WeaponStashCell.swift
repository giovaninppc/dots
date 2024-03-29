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
        MoneyController.purchase(value: weapon.price)
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
    private var canBePurchased: Bool = false

    private let drag: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.9
        return imageView
    }()

    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let priceTag: UILabel = {
        let label = UILabel()
        label.font = .sketch(size: 15.0)
        label.textColor = .black
        label.textAlignment = .center
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
                priceTag.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 2.0)
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
            if canBePurchased {
                notified = false
                addDragToView(from: gesture)
            } else {
                shake()
            }
        case .changed:
            guard canBePurchased else { return }
            notifyDragIfNeeded()
            let translation = gesture.translation(in: superview ?? self)
            drag.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        case .ended:
            guard canBePurchased else { return }
            delegate?.didDrop(weapon: type, from: gesture)
            drag.removeFromSuperview()
        default:
            guard canBePurchased else { return }
            drag.removeFromSuperview()
            delegate?.dragCanceled()
        }
    }

    private func notifyDragIfNeeded() {
        guard !notified else { return }
        notified = true
        delegate?.beginDrag()
    }

    private func addDragToView(from gesture: UIPanGestureRecognizer) {
        let view = (delegate as? UIViewController)?.view
        let point = gesture.location(in: view)
        drag.frame = image.frame
        drag.center = point
        drag.alpha = 0.0
        view?.addSubview(drag)
        UIView.animate(withDuration: .defaultAnimation) { self.drag.alpha = 1.0 }
    }

    private func shake() {
        transform = CGAffineTransform(translationX: 10, y: 0)
        HapticWorker(type: .error).fire()
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: { self.transform = CGAffineTransform.identity },
            completion: nil
        )
    }
}

extension WeaponStashCell {
    struct ViewModel {
        let type: WeaponType
    }

    func configure(with display: ViewModel) {
        configureContent(with: display)
        configureState(with: display)
    }

    private func configureContent(with display: ViewModel) {
        type = display.type
        priceTag.text = "$ \(display.type.price)"
        image.image = display.type.icon()
        drag.image = display.type.icon()
    }

    private func configureState(with display: ViewModel) {
        canBePurchased = MoneyController.canPurchase(price: display.type.price)
        image.alpha = canBePurchased ? 1.0 : 0.9
        priceTag.textColor = canBePurchased ? .black : .gray
    }
}
