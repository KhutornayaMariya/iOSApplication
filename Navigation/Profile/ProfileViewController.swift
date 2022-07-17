//
//  ProfileViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 17.07.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let dataItems: [PostModel] = [
        PostModel(author: "Vitalii", description: "I am so happy!", image: "1", likes: 3, views: 122),
        PostModel(author: "Timur", description: "Hello everyone!", image: "2", likes: 33, views: 54),
        PostModel(author: "Larisa", description: "welcome to my board", image: "3", likes: 23, views: 90),
        PostModel(author: "Ura", description: "Hahahaah lol", image: "4", likes: 13, views: 13),
        PostModel(author: "Nikolay",
                  description: "Autumn is here, and that means the risk of hitting deer on rural roads and highways is rising, especially around dusk and during a full moon.\nDeer cause over 1 million motor vehicle accidents in the U.S. each year, resulting in more than US$1 billion in property damage, about 200 human deaths and 29,000 serious injuries. Property damage insurance claims average around $2,600 per accident, and the overall average cost, including severe injuries or death, is over $6,000.\nWhile avoiding deer – as well as moose, elk and other hoofed animals, known as ungulates – can seem impossible if you’re driving in rural areas, there are certain times and places that are most hazardous, and so warrant extra caution.",
                  image: "5",
                  likes: 9,
                  views: 55)
    ]

    private let nc = NotificationCenter.default

    private var tableViewConstraint: NSLayoutConstraint!

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)

        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension

        view.register(PostCell.self, forCellReuseIdentifier: String(describing: PostCell.self))

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
        view.backgroundColor = .white
        view.addSubview(tableView)

        tableViewConstraint = tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)


        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewConstraint
        ])
    }
}

extension ProfileViewController: UITableViewDelegate { }

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as! PostCell
        cell.configure(with: dataItems[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ProfileHeaderView()
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tableView.tableHeaderView?.endEditing(true)
        return true
    }
}

private extension Int {
    static let headerViewSection: Int = 0
}
