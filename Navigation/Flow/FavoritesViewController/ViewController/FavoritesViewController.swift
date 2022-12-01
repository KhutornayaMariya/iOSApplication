//
//  FavoritesViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 09.11.2022.
//

import Foundation
import UIKit
import CoreData

final class FavoritesViewController: UIViewController {

    var fetchedResultsController: NSFetchedResultsController<Post>!

    private lazy var searchController: UISearchController = {
        let view = UISearchController(searchResultsController: nil)

        view.searchBar.searchTextField.placeholder = "AUTHOR_NAME".localized
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
        initFetchResultsController()
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

    private func initFetchResultsController() {
        if let searchText = searchController.searchBar.text,
              !searchText.isEmpty {
            fetchedResultsController =  CoreDataManager.defaultManager.searchPosts(with: searchText)
        } else {
            fetchedResultsController = CoreDataManager.defaultManager.getLikedPosts()
        }

        fetchedResultsController.delegate = self
    }
}

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as! PostCell
        let post = fetchedResultsController.object(at: indexPath)
        cell.configure(with: PostModelFactory(post).postModel)
        cell.selectionStyle = .none
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (_, _, _) in
            guard let self = self else { return }
            let post = self.fetchedResultsController.object(at: indexPath)
            post.updateLikes()
        }
        return .init(actions: [action])
    }
}

extension FavoritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        initFetchResultsController()
        tableView.reloadData()
    }
}

extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {

        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            print("Fatal error")
        }
    }
}
