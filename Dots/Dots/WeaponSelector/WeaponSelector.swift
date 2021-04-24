import UIKit

final class WeaponSelectorView: UIView {
    var onDismiss: (() -> Void)?

    private let dimmer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Build"
        label.textAlignment = .center
        label.font = .sketch(size: 30.0)
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("x", for: .normal)
        button.titleLabel?.font = .sketch(size: 30.0)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()

    private let weaponsCarousel: WeaponCarousel = {
        let carousel = WeaponCarousel()
        return carousel
    }()

    private let platformsCarousel: WeaponCarousel = {
        let carousel = WeaponCarousel()
        return carousel
    }()

    private let specialsCarousel: WeaponCarousel = {
        let carousel = WeaponCarousel()
        return carousel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension WeaponSelectorView {
    private func setup() {
        setupComponents()
        setupConstraints()
    }

    private func setupComponents() {
        dimmer.setupForManualConstraining()
        addSubview(dimmer)
        titleLabel.setupForManualConstraining()
        addSubview(titleLabel)
        closeButton.setupForManualConstraining()
        addSubview(closeButton)
        weaponsCarousel.setupForManualConstraining()
        addSubview(weaponsCarousel)
        platformsCarousel.setupForManualConstraining()
        addSubview(platformsCarousel)
        specialsCarousel.setupForManualConstraining()
        addSubview(specialsCarousel)
    }

    private func setupConstraints() {
        constrainDimmer()
        constrainTitle()
        constrainCloseButton()
        constrainWeaponCarousel()
        constrainPlatformCarousel()
        constrainSpecialsCarousel()
    }

    private func constrainDimmer() {
        constrain {
            [
                dimmer.topAnchor.constraint(equalTo: topAnchor),
                dimmer.bottomAnchor.constraint(equalTo: bottomAnchor),
                dimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
                dimmer.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        }
    }

    private func constrainTitle() {
        constrain {
            [
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25.0),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        }
    }

    private func constrainCloseButton() {
        constrain {
            [
                closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
                closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0)
            ]
        }
    }

    private func constrainWeaponCarousel() {
        constrain {
            [
                weaponsCarousel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40.0),
                weaponsCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
                weaponsCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
                weaponsCarousel.heightAnchor.constraint(equalToConstant: 180.0)
            ]
        }
    }

    private func constrainPlatformCarousel() {
        constrain {
            [
                platformsCarousel.topAnchor.constraint(equalTo: weaponsCarousel.bottomAnchor, constant: 10.0),
                platformsCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
                platformsCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
                platformsCarousel.heightAnchor.constraint(equalToConstant: 180.0)
            ]
        }
    }

    private func constrainSpecialsCarousel() {
        constrain {
            [
                specialsCarousel.topAnchor.constraint(equalTo: platformsCarousel.bottomAnchor, constant: 10.0),
                specialsCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
                specialsCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
                specialsCarousel.heightAnchor.constraint(equalToConstant: 180.0)
            ]
        }
    }
}

extension WeaponSelectorView {
    @objc private func dismiss() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.alpha = 0
        } completion: { [weak self] _ in
            self?.isHidden = true
            self?.onDismiss?()
        }
    }
}
