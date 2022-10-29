//
//  LogInViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit
import FirebaseAuth

final class LogInViewController: UIViewController {

    private let nc = NotificationCenter.default
    private var handle: AuthStateDidChangeListenerHandle?

    static var loginDelegate: LoginViewControllerDelegate?

    private lazy var loginView: LoginView = {
        let view = LoginView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTapButtonHandler = didTapLoginButton
        view.onTapSignInButtonHandler = didTapSignInButton

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

        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // ...
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        Auth.auth().removeStateDidChangeListener(handle!)
        
        loginView.cleanInputs()
    }

    private func setUp() {
        view.backgroundColor = .white
        view.addSubview(loginView)

        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    @objc
    private func keyboardHide() {
        loginView.scrollViewConstraint.constant = 0
        view.setNeedsLayout()
    }

    @objc
    private func keyboardShow(notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        loginView.scrollViewConstraint.constant = -frame.size.height
        view.setNeedsLayout()
    }

    @objc
    private func didTapLoginButton() {
#if DEBUG
        let userService = TestUserService()
#else
        let userService = CurrentUserService()
#endif

        guard let loginDelegate = LogInViewController.loginDelegate else { return }

        loginDelegate.checkCredentials(email: loginView.getLogin(), password: loginView.getPassword()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                let profileModel = ProfileViewModel(user: userService.getUser())
                self.navigationController?.pushViewController(ProfileViewController(viewModel: profileModel), animated: true)
            case .failure(_):
                self.present(self.alert, animated: true, completion: nil)
            }
        }
    }

    @objc
    private func didTapSignInButton() {
        present(RegistrationViewController(delegate: LogInViewController.loginDelegate), animated: true)
    }
}

private extension String {
    static let alertTitle = "Ошибка авторизации"
    static let alertMessage = "Введенные вами логин или пароль неверные"
    static let alertAction = "Повторить"
}
