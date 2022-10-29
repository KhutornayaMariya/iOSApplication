//
//  LoginView.swift
//  Navigation
//
//  Created by m.khutornaya on 29.10.2022.
//

import UIKit

class LoginView: UIView {

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

    private lazy var logo: UIImageView = {
        let view = UIImageView()

        view.image = UIImage(named: "VK logo")
        view.contentMode = .scaleToFill
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

        view.placeholder = "Phone or email"
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

        view.placeholder = "Password"
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

    private lazy var loginButton: CustomButton = {
        let view = CustomButton(title: "Log In", titleColor: .white)

        let image = UIImage(named: "blue_pixel")
        view.setBackgroundImage(image, for: .normal)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    public var onTapButtonHandler: (() -> Void)? {
        didSet {
            loginButton.addTarget(self, action: #selector(tapWrapper), for: .touchUpInside)
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

        let subviews = [logo, backgroundView, loginButton]
        subviews.forEach { contentView.addSubview($0) }

        [inputLoginField, inputPasswordField, separator].forEach { backgroundView.addSubview($0) }

        scrollViewConstraint = scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollViewConstraint,
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .vertical),
            logo.widthAnchor.constraint(equalToConstant: .size),
            logo.heightAnchor.constraint(equalToConstant: .size),
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            backgroundView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: .size),
            backgroundView.heightAnchor.constraint(equalToConstant: .size),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .safeArea),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.safeArea),

            loginButton.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: .safeArea),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .safeArea),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.safeArea),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

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
            inputPasswordField.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])
    }

    @objc
    private func tapWrapper() {
        self.onTapButtonHandler?()
    }
}

extension LoginView {

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

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

private extension CGFloat {
    static let size: CGFloat = 100
    static let safeArea: CGFloat = 16
    static let vertical: CGFloat = 120
}
