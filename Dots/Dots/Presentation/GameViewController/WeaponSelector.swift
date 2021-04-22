import UIKit

final class WeaponSelectorView: UIView {
    var onDismiss: (() -> Void)?

    private let dimmer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Build"
        label.textAlignment = .center
        label.font = .sketch(size: 24.0)
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("x", for: .normal)
        button.titleLabel?.font = .sketch(size: 30.0)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
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
        titleLabel.setupForManualConstraining()
        closeButton.setupForManualConstraining()
    }

    private func setupConstraints() {
        constrainDimmer()
        constrainTitle()
        constrainCloseButton()
    }

    private func constrainDimmer() {
        addSubview(dimmer)
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
        addSubview(titleLabel)
        constrain {
            [
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25.0),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        }
    }

    private func constrainCloseButton() {
        addSubview(closeButton)
        constrain {
            [
                closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
                closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0)
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
