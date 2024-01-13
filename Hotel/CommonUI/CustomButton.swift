//
//  CustomButton.swift
//  Hotel
//
//  Created by ily.pavlov on 08.01.2024.
//

import UIKit

class CustomButton: UIButton {

    private var tapAction: (() -> Void)?

    init(text: String) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        self.backgroundColor = UIColor.systemBlue
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = 15
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        tapAction?()
    }

    func addAction(_ action: @escaping () -> Void) {
        tapAction = action
    }
}
