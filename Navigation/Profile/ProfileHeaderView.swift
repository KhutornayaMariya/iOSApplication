//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit

final class ProfileHeaderView: UIView {

    private lazy var userName: UILabel = {
        let view = UILabel()

        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        view.text = "Hipster Cat"
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var userImage: UIImageView = {
        let view = UIImageView()

        view.layer.borderWidth = 3
        view.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = .imageSize/2
        view.image = UIImage(named: "ice")
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

    private lazy var inputField: UITextField = {
        let view = UITextField()

        view.placeholder = "Waiting for something"
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.tintColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        backgroundColor = .white
        let subviews = [userName, userImage, statusButton, inputField]
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

            inputField.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34),
            inputField.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: .safeArea),
            inputField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea)
        ])
    }

    @objc
    private func onButtonTapHander() {
        guard let status = inputField.text,
           !status.isEmpty else {
            print("Nothing to show")
            return
        }
        inputField.endEditing(true)
        print(status)
    }
}

private extension CGFloat {
    static let safeArea: CGFloat = 16
    static let imageSize: CGFloat = 100
}
