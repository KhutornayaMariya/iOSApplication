//
//  ProfileViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    var backgroundColor: UIColor = .lightGray

    init(_ color: UIColor, _ title: String) {
        super.init(nibName: nil, bundle: nil)
        backgroundColor = color
        self.title = title
    }

    private lazy var headerView: ProfileHeaderView = {
        let view = ProfileHeaderView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    override func viewWillLayoutSubviews() {
        headerView.frame = view.frame
    }

    private func setUp() {
        view.backgroundColor = backgroundColor
        view.addSubview(headerView)

        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
