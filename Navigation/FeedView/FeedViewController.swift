//
//  FeedViewController.swift
//  Navigation
//
//  Created by Mariia Khutornaia on 20.04.2022.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    weak var parentNavigationController: UINavigationController?
    
    var backgroundColor: UIColor = .white
    
    init(_ color: UIColor, _ title: String, parent parentNavigationController: UINavigationController) {
        super.init(nibName: nil, bundle: nil)
        backgroundColor = color
        self.title = title
        self.parentNavigationController = parentNavigationController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = FeedView()
        view.button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        view.backgroundColor = backgroundColor
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    func onButtonTap() {
        parentNavigationController?.pushViewController(PostViewController(.orange, getPost()), animated: true)
    }
    
    private func getPost() -> Post {
        return Post(title: "New post!")
    }
}
