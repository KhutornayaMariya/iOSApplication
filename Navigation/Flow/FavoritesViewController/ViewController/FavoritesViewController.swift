//
//  FavoritesViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 09.11.2022.
//

import Foundation
import UIKit

final class FavoritesViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)

        view.dataSource = self
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.register(PostCell.self, forCellReuseIdentifier: String(describing: PostCell.self))

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    private func setUp() {
        view.backgroundColor = .white
        title = "Favorites"

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.defaultManager.getLikedPosts().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as! PostCell
        let post = CoreDataManager.defaultManager.getLikedPosts()[indexPath.row]
        cell.configure(with: PostModelFactory(post).postModel)
        cell.selectionStyle = .none
        return cell
    }

    private func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel()
        headerView.text = "Favorites"
        return headerView
    }
}
