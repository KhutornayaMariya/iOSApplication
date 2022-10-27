//
//  FeedView.swift
//  Navigation
//
//  Created by Mariia Khutornaia on 20.04.2022.
//

import UIKit

class FeedView: UIView {
    
    private var button: CustomButton = {
        let button = CustomButton(title: "Button", titleColor: .black)

        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var inputField: UITextField = {
        let view = UITextField()

        view.placeholder = "Guess the word"
        view.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        view.textColor = .black
        view.backgroundColor = .white
        view.textAlignment = .left
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Check", titleColor: .black)

        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private var label: UILabel = {
        let label = UILabel()

        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 12
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder) has not been implemented")
    }

    private func setUp() {
        let subviews = [button, inputField, checkGuessButton, label]
        subviews.forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .safeArea),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),
            button.heightAnchor.constraint(equalToConstant: 50),

            inputField.topAnchor.constraint(equalTo: button.bottomAnchor, constant: .safeArea),
            inputField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),
            inputField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),
            inputField.heightAnchor.constraint(equalToConstant: 50),

            checkGuessButton.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: .safeArea),
            checkGuessButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),
            checkGuessButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),

            label.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: .safeArea),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func setCheckGuessButtonTapAction(action: @escaping () -> Void) {
        checkGuessButton.tapAction = action
    }

    func setButtonTapAction(action: @escaping () -> Void) {
        button.tapAction = action
    }

    func getInputText() -> String {
        guard let text = inputField.text else {
            return ""
        }
        return text
    }

    func setLabelColor(_ color: UIColor) {
        label.backgroundColor = color
    }
}

private extension CGFloat {
    static let safeArea: CGFloat = 16
}
