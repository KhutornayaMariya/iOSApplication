//
//  PostViewController.swift
//  Navigation
//
//  Created by Mariia Khutornaia on 20.04.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post
    var backgroundColor: UIColor = .white
    
    init(_ color:UIColor, _ post:Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
        backgroundColor = color
        let infoButtonItem = UIBarButtonItem(
                    image: UIImage(systemName: "info"),
                    style: UIBarButtonItem.Style.plain,
                    target: self,
                    action: #selector(openInfoButtomSheet)
                )
        navigationItem.rightBarButtonItem = infoButtonItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = backgroundColor
        self.title = post.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    func openInfoButtomSheet() {
        present(InfoViewController(.lightGray), animated: true, completion: nil)
    }
}
