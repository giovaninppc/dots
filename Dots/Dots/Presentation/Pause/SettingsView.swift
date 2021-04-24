import UIKit

final class PauseView: UIView {
    var onDismiss: (() -> Void)?

    private let dimmer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Pause"
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension PauseView {
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
    }

    private func setupConstraints() {
        constrainDimmer()
        constrainTitle()
        constrainCloseButton()
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
}

extension PauseView {
    @objc private func dismiss() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.alpha = 0
        } completion: { [weak self] _ in
            self?.isHidden = true
            self?.onDismiss?()
        }
    }
}
