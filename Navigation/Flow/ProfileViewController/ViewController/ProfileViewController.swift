//
//  ProfileViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let viewModel: ProfileViewModel
    private var dataItems: [Post] {
        CoreDataManager.defaultManager.posts
    }

    private let nc = NotificationCenter.default

    private var tableViewConstraint: NSLayoutConstraint!

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)

        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.backgroundColor = .clear

        view.register(PostCell.self, forCellReuseIdentifier: String(describing: PostCell.self))
        view.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))

        return view
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.setContentOffset(.zero, animated: true)
        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc private func keyboardShow(notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        tableViewConstraint.constant = -frame.size.height
        tableView.isScrollEnabled = false
        view.setNeedsLayout()
    }

    @objc private func keyboardHide() {
        tableViewConstraint.constant = 0
        tableView.isScrollEnabled = true
        view.setNeedsLayout()
    }

    private func setUp() {
        #if DEBUG
        view.backgroundColor = .lightGray
        #else
        view.backgroundColor = .white
        #endif

        view.addSubview(tableView)
        title = "Profile"

        tableViewConstraint = tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)


        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewConstraint
        ])
    }

    private func didPostTap(index: Int) {
        let post = dataItems[index]
        post.updateLikes()
        tableView.reloadData()
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case .photoGallerySection:
            navigationController?.pushViewController(PhotoGalleryViewController(), animated: true)
        default:
            break
        }
    }
}

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case .photoGallerySection:
            return 1
        default:
            return dataItems.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case .photoGallerySection:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as! PostCell
            let item = dataItems[indexPath.row]
            cell.configure(with: PostModelFactory(item).postModel)
            cell.selectionStyle = .none
            cell.onTapHander = { [weak self] in self?.didPostTap(index: indexPath.row) }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case .photoGallerySection:
            let headerView = ProfileHeaderView()
            headerView.configure(with: viewModel.user)
            return headerView
        default:
            return nil
        }
    }
}

private extension Int {
    static let photoGallerySection: Int = 0
}
