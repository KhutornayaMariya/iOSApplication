//
//  FeedViewController.swift
//  Navigation
//
//  Created by Mariia Khutornaia on 20.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    weak var parentNavigationController: UINavigationController?
    let model: FeedModel = FeedModel()
    let mainView: FeedView = FeedView()

    init(_ title: String, parent parentNavigationController: UINavigationController) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.parentNavigationController = parentNavigationController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
        mainView.setButtonTapAction(action: onButtonTap)
        mainView.setCheckGuessButtonTapAction(action: onCheckGuessButtonTap)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    func onButtonTap() {
        parentNavigationController?.pushViewController(PostViewController(), animated: true)
    }

    @objc
    func onCheckGuessButtonTap() {
        let result = model.check(mainView.getInputText())

        if result {
            mainView.setLabelColor(.systemGreen)
        } else {
            mainView.setLabelColor(.systemRed)
        }
    }
}
