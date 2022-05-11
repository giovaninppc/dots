import UIKit

final class PauseView: UIView {
    var onDismiss: (() -> Void)?
    var onCloseGame: (() -> Void)?
    var onSettings: (() -> Void)?

    private let dimmer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Localization.Pause.title
        label.textAlignment = .center
        label.font = .sketch(size: 30.0)
        return label
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.Pause.continue, for: .normal)
        button.titleLabel?.font = .sketch(size: 35.0)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()

    private lazy var endButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.Pause.exit, for: .normal)
        button.titleLabel?.font = .sketch(size: 35.0)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(closeGame), for: .touchUpInside)
        return button
    }()

    private let settingsButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(Asset.gear.image, for: .normal)
        button.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        button.addGearAnimation()
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { nil }
}

extension PauseView: CodeView {
    func setupComponents() {
        addSubview(dimmer)
        addSubview(titleLabel)
        addSubview(continueButton)
        addSubview(endButton)
        addSubview(settingsButton)
    }

    func setupConstraints() {
        constrain {
            [
                dimmer.topAnchor.constraint(equalTo: topAnchor),
                dimmer.bottomAnchor.constraint(equalTo: bottomAnchor),
                dimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
                dimmer.trailingAnchor.constraint(equalTo: trailingAnchor),

                titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25.0),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

                continueButton.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -10.0),
                continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),

                endButton.topAnchor.constraint(equalTo: centerYAnchor, constant: 10.0),
                endButton.centerXAnchor.constraint(equalTo: centerXAnchor),

                settingsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
                settingsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
                settingsButton.heightAnchor.constraint(equalToConstant: 35.0),
                settingsButton.widthAnchor.constraint(equalToConstant: 35.0)
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

    @objc private func didTapSettings() {
        onSettings?()
    }
}
