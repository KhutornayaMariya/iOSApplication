//
//  RegistrationView.swift
//  Navigation
//
//  Created by m.khutornaya on 29.10.2022.
//

import UIKit

class RegistrationView: UIView {

    public var scrollViewConstraint: NSLayoutConstraint!

    private let scrollView: UIScrollView = {
        let view = UIScrollView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let contentView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let title: UILabel = {
        let view = UILabel()

        view.text = "Регистрация"
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let backgroundView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 10

        return view
    }()

    private lazy var inputLoginField: UITextField = {
        let view = UITextField()

        view.placeholder = "Введите email"
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.autocapitalizationType = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.tintColor = .darkGray

        return view
    }()

    private lazy var inputPasswordField: UITextField = {
        let view = UITextField()

        view.placeholder = "Введите пароль"
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.autocapitalizationType = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSecureTextEntry = true
        view.delegate = self
        view.tintColor = .darkGray

        return view
    }()

    private let separator: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray

        return view
    }()

    private lazy var signInButton: CustomButton = {
        let view = CustomButton(title: "Продолжить", titleColor: .white)

        let image = UIImage(named: "blue_pixel")
        view.setBackgroundImage(image, for: .normal)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEnabled = false

        return view
    }()

    public var onTapButtonHandler: (() -> Void)? {
        didSet {
            signInButton.addTarget(self, action: #selector(tapWrapper), for: .touchUpInside)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        let subviews = [title, backgroundView, signInButton]
        subviews.forEach { contentView.addSubview($0) }

        [inputLoginField, inputPasswordField, separator].forEach { backgroundView.addSubview($0) }

        scrollViewConstraint = scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollViewConstraint,
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .safeArea),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .safeArea),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.safeArea),

            backgroundView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: .safeArea),
            backgroundView.heightAnchor.constraint(equalToConstant: .size),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .safeArea),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.safeArea),

            inputLoginField.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            inputLoginField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: .safeArea),
            inputLoginField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -.safeArea),
            inputLoginField.heightAnchor.constraint(equalToConstant: 50),

            separator.heightAnchor.constraint(equalToConstant: 0.5),
            separator.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            separator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),

            inputPasswordField.topAnchor.constraint(equalTo: inputLoginField.bottomAnchor),
            inputPasswordField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: .safeArea),
            inputPasswordField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -.safeArea),
            inputPasswordField.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),

            signInButton.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: .safeArea),
            signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .safeArea),
            signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.safeArea),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc
    private func tapWrapper() {
        self.onTapButtonHandler?()
    }

    private func isInputsFilled() -> Bool {
        guard let password = inputPasswordField.text,
              let login = inputLoginField.text
        else {
            return false
        }
        return !password.isEmpty && !login.isEmpty
    }
}

extension RegistrationView {

    public func cleanInputs() {
        inputPasswordField.text = nil
        inputLoginField.text = nil
    }

    public func getLogin() -> String {
        return inputLoginField.text!
    }

    public func getPassword() -> String {
        return inputPasswordField.text!
    }
}

extension RegistrationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if isInputsFilled() {
            signInButton.isEnabled = true
        } else {
            signInButton.isEnabled = false
        }
    }
}

private extension CGFloat {
    static let size: CGFloat = 100
    static let safeArea: CGFloat = 16
    static let vertical: CGFloat = 120
}
