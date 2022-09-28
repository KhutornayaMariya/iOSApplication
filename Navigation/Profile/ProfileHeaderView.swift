//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit

final class ProfileHeaderView: UIView {

    private var statusText: String = "Hi everyone"

    private lazy var userName: UILabel = {
        let view = UILabel()

        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var userImage: UIImageView = {
        let view = UIImageView()

        view.layer.borderWidth = 3
        view.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = .imageSize/2
        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var statusButton: UIButton = {
        let view = UIButton()

        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 4
        view.setTitle("Show status", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        view.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOpacity = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(onButtonTapHander), for: .touchUpInside)

        return view
    }()

    private lazy var statusLabel: UILabel = {
        let view = UILabel()

        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var inputField: UITextField = {
        let view = UITextField()

        view.placeholder = "What is your mood?"
        view.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        view.textColor = .black
        view.backgroundColor = .white
        view.textAlignment = .left
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)

        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with user: User) {
        userName.text = user.name
        userImage.image = user.avatar
        statusLabel.text = user.status
    }

    private func setUp() {
        backgroundColor = .clear
        let subviews = [userName, userImage, statusButton, inputField, statusLabel]
        subviews.forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: topAnchor, constant: .safeArea),
            userImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),
            userImage.heightAnchor.constraint(equalToConstant: .imageSize),
            userImage.widthAnchor.constraint(equalToConstant: .imageSize),

            statusButton.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: .safeArea),
            statusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),
            statusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.safeArea),

            userName.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: .safeArea),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),

            statusLabel.bottomAnchor.constraint(equalTo: inputField.topAnchor, constant: -5),
            statusLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: .safeArea),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),

            inputField.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -.safeArea),
            inputField.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: .safeArea),
            inputField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),
            inputField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc
    private func onButtonTapHander() {
        statusLabel.text = statusText
        inputField.text = ""
        inputField.endEditing(true)
    }

    @objc
    private func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        statusText = text
    }
}

private extension CGFloat {
    static let safeArea: CGFloat = 16
    static let imageSize: CGFloat = 100
}
