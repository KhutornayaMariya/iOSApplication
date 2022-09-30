//
//  LogInViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit

final class LogInViewController: UIViewController {

    private let nc = NotificationCenter.default

    private var scrollViewConstraint: NSLayoutConstraint!

    static var loginDelegate: LoginViewControllerDelegate?

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

    private lazy var loginButton: UIButton = {
        let view = UIButton()

        view.setTitle("Log In", for: .normal)
        view.setTitleColor(.white, for: .normal)
        let image = UIImage(named: "blue_pixel")
        view.setBackgroundImage(image, for: .normal)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)

        return view
    }()

    private let alert: UIAlertController = {
        let alert = UIAlertController(title: String.alertTitle, message: String.alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: String.alertAction, style: .default, handler: nil)
        alert.addAction(action)

        return alert
    }()

    // MARK: Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true

        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    private func setUp() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        let subviews = [logo, backgroundView, loginButton]
        subviews.forEach { contentView.addSubview($0) }

        [inputLoginField, inputPasswordField, separator].forEach { backgroundView.addSubview($0) }

        scrollViewConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollViewConstraint,
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

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
    private func keyboardHide() {
        scrollViewConstraint.constant = 0
        view.setNeedsLayout()
    }

    @objc
    private func keyboardShow(notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollViewConstraint.constant = -frame.size.height
        view.setNeedsLayout()
    }

    @objc
    private func didTapLoginButton() {
#if DEBUG
        let userService = TestUserService()
#else
        let userService = CurrentUserService()
#endif

        guard let loginDelegate = LogInViewController.loginDelegate,
              loginDelegate.check(login: inputLoginField.text!, password: inputPasswordField.text!)
        else {
            present(alert, animated: true, completion: nil)
            return
        }
        cleanInputs()

        let user = userService.getUser()
        navigationController?.pushViewController(ProfileViewController(user: user), animated: true)
    }

    private func cleanInputs () {
        inputPasswordField.text = nil
        inputLoginField.text = nil
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

private extension CGFloat {
    static let size: CGFloat = 100
    static let safeArea: CGFloat = 16
    static let vertical: CGFloat = 120
}

private extension String {
    static let alertTitle = "Ошибка авторизации"
    static let alertMessage = "Введенные вами логин или пароль неверные"
    static let alertAction = "Повторить"
}