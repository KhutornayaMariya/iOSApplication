//
//  LogInViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit

final class LogInViewController: UIViewController {

    private typealias auth = FirebaseAuthorization.auth
    private let nc = NotificationCenter.default
    private var handle: FirebaseAuthorization.listener?

    private lazy var loginDelegate: LoginViewControllerDelegate = LoginInspector()

    private lazy var loginView: LoginView = {
        let view = LoginView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTapButtonHandler = didTapLoginButton

        return view
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

        handle = auth.auth().addStateDidChangeListener { auth, user in }
    }

    override func viewDidDisappear(_ animated: Bool) {
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        auth.auth().removeStateDidChangeListener(handle!)
        
        loginView.cleanInputs()
        loginView.disableButtons()
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
        loginDelegate.checkCredentials(email: loginView.getLogin(),
                                       password: loginView.getPassword())
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.openProfileVC()
            case .failure(let error):
                if error.code == .noSuchUserErrorCode {
                    self.createNewUser()
                } else {
                    print(error)
                    self.showAlert(alertTitle: .signUpError, errorCode: error.code)
                }
            }
        }
    }

    private func createNewUser() {
        loginDelegate.signUp(email: loginView.getLogin(),
                             password: loginView.getPassword())
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.openProfileVC()
            case .failure(let error):
                print(error)
                self.showAlert(alertTitle: .signInError, errorCode: error.code)
            }
        }
    }

    private func openProfileVC() {
        let userService = CurrentUserService()

        let profileModel = ProfileViewModel(user: userService.getUser())
        self.navigationController?.pushViewController(ProfileViewController(viewModel: profileModel), animated: true)
    }

    private func showAlert( alertTitle: String, errorCode: Int) {
        let message = getAlertMessage(errorCode: errorCode)

        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: String.alertAction, style: .default, handler: nil)
        alertController.addAction(action)

        present(alertController, animated: true)
    }

    private func getAlertMessage(errorCode: Int) -> String {
        switch errorCode {
        case .shortPasswordErrorCode:
            return .shortPassword
        case .noSuchUserErrorCode:
            return .noSuchUserError
        case .invalidEmailAddressErrorCode:
            return .invalidEmailAddress
        case .wrongCredsErrorCode:
            return .wrongCredsError
        default:
            return .errorMessage
        }
    }
}

private extension String {
    static let signUpError = "Ошибка авторизации"
    static let wrongCredsError = "Введенные вами логин или пароль неверные"
    static let noSuchUserError =  "Пользователь не найден. Проверьте правильность логина или зарегистрируйтесь"

    static let signInError = "Ошибка регистрации"
    static let shortPassword = "Пароль должен содержать как минимум 6 символов"

    static let alertAction = "Повторить"
    static let errorMessage = "Произошла ошибка. Повторите позже"
    static let invalidEmailAddress = "Некорректный формат email. Убедитесь, что email соответствует формату example@ex.com"
}

private extension Int {
    static let shortPasswordErrorCode = 17026
    static let noSuchUserErrorCode =  17011
    static let wrongCredsErrorCode =  17009
    static let invalidEmailAddressErrorCode = 17008
}
