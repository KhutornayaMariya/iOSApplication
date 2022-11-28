//
//  InfoView.swift
//  Navigation
//
//  Created by Mariia Khutornaia on 20.04.2022.
//

import UIKit

class InfoView: UIView {

    private lazy var title: UILabel = {
        let view = UILabel()

        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var periodTitle: UILabel = {
        let view = UILabel()

        view.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var residentsButton: CustomButton = {
        let button = CustomButton(title: .residentsButtonText, titleColor: .blue)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var button: CustomButton = {
        let button = CustomButton(title: .buttonText, titleColor: .blue)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    public var onTapButtonHandler: (() -> Void)? {
        didSet {
            button.addTarget(self, action: #selector(tapWrapper), for: .touchUpInside)
        }
    }

    public var onTapResidentsButtonHandler: (() -> Void)? {
        didSet {
            residentsButton.addTarget(self, action: #selector(tapResidentsWrapper), for: .touchUpInside)
        }
    }

    public func configureTitle(with text: String) {
        title.text = text
    }

    public func configurePeriodTitle(with text: String) {
        periodTitle.text = "Orbital period of Tatooine: " + text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp() {
        let subviews = [button, title, periodTitle, residentsButton]
        subviews.forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),

            periodTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 40),
            periodTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            periodTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            residentsButton.widthAnchor.constraint(equalToConstant: .width),
            residentsButton.heightAnchor.constraint(equalToConstant: .height),
            residentsButton.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -40),
            residentsButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            button.widthAnchor.constraint(equalToConstant: .width),
            button.heightAnchor.constraint(equalToConstant: .height),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder) has not been implemented")
    }

    @objc
    private func tapWrapper() {
        self.onTapButtonHandler?()
    }

    @objc
    private func tapResidentsWrapper() {
        self.onTapResidentsButtonHandler?()
    }
}

private extension CGFloat {
    static let width: CGFloat = 200
    static let height: CGFloat = 100
}

private extension String {
    static let buttonText = "Tap here"
    static let residentsButtonText = "Show planet residents"
}
