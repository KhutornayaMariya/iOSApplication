//
//  PlanetResidentsViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 28.10.2022.
//

import UIKit
import Foundation

struct PlanetResidentsModel {
    let urls: [String]
}

final class PlanetResidentsViewController: UIViewController {

    var networkManager: NetworkManagerProtocol = NetworkManager()
    var residentNames: [String] = []
    var model: PlanetResidentsModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.fetchPlanetResidents()
    }

    // MARK: Lifecycle

    init(model: PlanetResidentsModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        view.backgroundColor = .systemBackground

        view.addSubview(self.tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchPlanetResidents() {
        for urlString in model.urls {
            guard let url = URL(string: urlString) else { return }

            networkManager.request(url: url) { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let residentData = try JSONDecoder().decode(ResidentModel.self, from: data)
                        self?.residentNames.append(residentData.name)
                        self?.tableView.reloadData()
                    } catch let error {
                        print("🍎", error)
                    }

                case .failure(let error):
                    print("🍎", error)
                }
            }
        }
    }
}

extension PlanetResidentsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        residentNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        cell.textLabel?.text = self.residentNames[indexPath.row]
        return cell
    }
}
