//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import SnapKit

final class ProfileHeaderView: UIView {

    private var statusText: String = "Hi everyone"

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

    private lazy var statusLabel: UILabel = {
        let view = UILabel()

        view.text = statusText
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

    private func setUp() {
        backgroundColor = .clear
        let subviews = [userName, userImage, statusButton, inputField, statusLabel]
        subviews.forEach { addSubview($0) }

        userImage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(CGFloat.safeArea)
            make.left.equalTo(self).offset(CGFloat.safeArea)
            make.height.equalTo(CGFloat.imageSize)
            make.width.equalTo(CGFloat.imageSize)
        }

        statusButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(userImage.snp.bottom).offset(CGFloat.safeArea)
            make.left.equalTo(self).offset(CGFloat.safeArea)
            make.right.equalTo(self).offset(-CGFloat.safeArea)
            make.height.equalTo(50)
            make.width.equalTo(CGFloat.imageSize)
            make.bottom.equalTo(self).offset(-CGFloat.safeArea)
        }

        userName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(27)
            make.left.equalTo(userImage.snp.right).offset(CGFloat.safeArea)
            make.right.equalTo(self).offset(-CGFloat.safeArea)
        }

        statusLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(inputField.snp.top).offset(-5)
            make.left.equalTo(userImage.snp.right).offset(CGFloat.safeArea)
            make.right.equalTo(self).offset(-CGFloat.safeArea)
        }

        inputField.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(userImage.snp.right).offset(CGFloat.safeArea)
            make.right.equalTo(self).offset(-CGFloat.safeArea)
            make.height.equalTo(40)
            make.bottom.equalTo(statusButton.snp.top).offset(-CGFloat.safeArea)
        }
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
