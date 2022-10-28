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

        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .purple
        self.isOpaque = false
        addSubview(button)
        configureLayout()
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
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
}

private extension CGFloat {
    static let width: CGFloat = 200
    static let height: CGFloat = 100
}

private extension String {
    static let buttonText = "Tap here"
}
