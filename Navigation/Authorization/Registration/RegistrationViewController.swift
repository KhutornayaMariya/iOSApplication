//
//  RegistrationViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 29.10.2022.
//

import Foundation
import UIKit
import FirebaseAuth

final class RegistrationViewController: UIViewController {

    private let nc = NotificationCenter.default
    private var handle: AuthStateDidChangeListenerHandle?
    private weak var loginDelegate: LoginViewControllerDelegate?

    private lazy var registrationView: RegistrationView = {
        let view = RegistrationView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTapButtonHandler = didTapSignInButton

        return view
    }()

    private let alert: UIAlertController = {
        let alert = UIAlertController(title: String.alertTitle, message: String.alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: String.alertAction, style: .default, handler: nil)
        alert.addAction(action)

        return alert
    }()

    // MARK: Lifecycle

    init(delegate: LoginViewControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.loginDelegate = delegate

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

        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // ...
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        Auth.auth().removeStateDidChangeListener(handle!)

        registrationView.cleanInputs()
    }

    private func setUp() {
        view.backgroundColor = .white
        view.addSubview(registrationView)

        NSLayoutConstraint.activate([
            registrationView.topAnchor.constraint(equalTo: view.topAnchor),
            registrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registrationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            registrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    @objc
    private func keyboardHide() {
        registrationView.scrollViewConstraint.constant = 0
        view.setNeedsLayout()
    }

    @objc
    private func keyboardShow(notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        registrationView.scrollViewConstraint.constant = -frame.size.height
        view.setNeedsLayout()
    }

    @objc
    private func didTapSignInButton() {

        guard let loginDelegate = loginDelegate else { return }

        loginDelegate.signUp(email: registrationView.getLogin(),
                                 password: registrationView.getPassword()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.dismiss(animated: true)
            case .failure(let error):
                print(error)
                self.present(self.alert, animated: true, completion: nil)
            }
        }
    }
}

private extension String {
    static let alertTitle = "Ошибка авторизации"
    static let alertMessage = "Введенные вами логин или пароль неверные"
    static let alertAction = "Повторить"
}
