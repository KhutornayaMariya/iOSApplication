//
//  FavoritesViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 09.11.2022.
//

import Foundation
import UIKit

final class FavoritesViewController: UIViewController {

    var posts: [Post] {
        guard let searchText = self.searchController.searchBar.text,
              !searchText.isEmpty else {
            return CoreDataManager.defaultManager.getLikedPosts()
        }
        return CoreDataManager.defaultManager.searchPosts(with: searchText)
    }

    private lazy var searchController: UISearchController = {
        let view = UISearchController(searchResultsController: nil)

        view.searchBar.searchTextField.placeholder = .authorName
        view.searchResultsUpdater = self

        return view
    }()

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)

        view.dataSource = self
        view.delegate = self
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
        navigationItem.searchController = searchController

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
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.configure(with: PostModelFactory(post).postModel)
        cell.selectionStyle = .none
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (_, _, _) in
            guard let self = self else { return }
            self.posts[indexPath.row].updateLikes()

            self.tableView.reloadData()
        }
        return .init(actions: [action])
    }
}

extension FavoritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
}

private extension String {
    static let authorName = "Имя автора"
}
