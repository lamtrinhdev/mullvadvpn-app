//
//  AccountDeviceRow.swift
//  MullvadVPN
//
//  Created by Mojgan on 2023-08-28.
//  Copyright © 2025 Mullvad VPN AB. All rights reserved.
//

import UIKit

class AccountDeviceRow: UIView {
    var deviceName: String? {
        didSet {
            deviceLabel.text = deviceName?.capitalized ?? ""
            accessibilityValue = deviceName
            setAccessibilityIdentifier(.accountPageDeviceNameLabel)
        }
    }

    var infoButtonAction: (() -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString(
            "DEVICE_NAME",
            tableName: "Account",
            value: "Device name",
            comment: ""
        )
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(white: 1.0, alpha: 0.6)
        return label
    }()

    private let deviceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()

    private let infoButton: UIButton = {
        let button = IncreasedHitButton(type: .system)
        button.isExclusiveTouch = true
        button.setAccessibilityIdentifier(.infoButton)
        button.tintColor = .white
        button.setBackgroundImage(UIImage.Buttons.info, for: .normal)
        button.heightAnchor.constraint(equalToConstant: UIMetrics.Button.accountInfoSize).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1).isActive = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let contentContainerView = UIStackView(arrangedSubviews: [titleLabel, deviceLabel])
        contentContainerView.axis = .vertical
        contentContainerView.alignment = .leading
        contentContainerView.spacing = 8

        addConstrainedSubviews([contentContainerView, infoButton]) {
            contentContainerView.pinEdgesToSuperview()
            infoButton.leadingAnchor.constraint(equalToSystemSpacingAfter: deviceLabel.trailingAnchor, multiplier: 1)
            infoButton.centerYAnchor.constraint(equalTo: deviceLabel.centerYAnchor)
        }

        isAccessibilityElement = true
        accessibilityLabel = titleLabel.text

        infoButton.addTarget(
            self,
            action: #selector(didTapInfoButton),
            for: .touchUpInside
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setButtons(enabled: Bool) {
        infoButton.isEnabled = enabled
    }

    @objc private func didTapInfoButton() {
        infoButtonAction?()
    }
}
