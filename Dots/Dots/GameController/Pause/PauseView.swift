import UIKit

final class PauseView: UIView {
    var onDismiss: (() -> Void)?
    var onCloseGame: (() -> Void)?

    private let dimmer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
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

    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .sketch(size: 35.0)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()

    private lazy var endButton: UIButton = {
        let button = UIButton()
        button.setTitle("Exit", for: .normal)
        button.titleLabel?.font = .sketch(size: 35.0)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(closeGame), for: .touchUpInside)
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
        continueButton.setupForManualConstraining()
        addSubview(continueButton)
        endButton.setupForManualConstraining()
        addSubview(endButton)
    }

    private func setupConstraints() {
        constrainDimmer()
        constrainTitle()
        constrainCloseButton()
        constrainContinueButton()
        constrainEndButton()
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
                titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25.0),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        }
    }

    private func constrainCloseButton() {
        constrain {
            [
                closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10.0),
                closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0)
            ]
        }
    }

    private func constrainContinueButton() {
        constrain {
            [
                continueButton.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -10.0),
                continueButton.centerXAnchor.constraint(equalTo: centerXAnchor)
            ]
        }
    }

    private func constrainEndButton() {
        constrain {
            [
                endButton.topAnchor.constraint(equalTo: centerYAnchor, constant: 10.0),
                endButton.centerXAnchor.constraint(equalTo: centerXAnchor)
            ]
        }
    }
}

extension PauseView {
    @objc private func dismiss() {
        onDismiss?()
    }

    @objc private func closeGame() {
        onCloseGame?()
    }
}
