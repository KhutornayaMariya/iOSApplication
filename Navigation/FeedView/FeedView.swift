//
//  FeedView.swift
//  Navigation
//
//  Created by Mariia Khutornaia on 20.04.2022.
//

import UIKit

class FeedView: UIView {

    var buttonView: UIView = {
        let buttonView = UIView()
        buttonView.backgroundColor = .red
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        return buttonView;
    }()
    
    var button: CustomButton = {
        let button = CustomButton(title: "button", titleColor: .magenta)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        addSubview(buttonView)
        buttonView.addSubview(button)
        configureLayout()
    }

    func configureLayout() {
        let views: [String: Any] = [
            "superView": self,
            "buttonView": buttonView,
            "button": button
        ]
        var constraintArray: [NSLayoutConstraint] = []

        constraintArray += NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[buttonView]-|", metrics: nil, views: views)
        constraintArray += NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[buttonView]-|", metrics: nil, views: views)
        constraintArray += NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[button]|", metrics: nil, views: views)
        constraintArray += NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[button]|", metrics: nil, views: views)
        NSLayoutConstraint.activate(constraintArray)
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder) has not been implemented")
    }
}
