//
//  InfoViewController.swift
//  Navigation
//
//  Created by Mariia Khutornaia on 20.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    var networkManager: NetworkManagerProtocol = NetworkManager()

    private lazy var infoView: InfoView = {
        let view = InfoView()

        view.onTapButtonHandler = openAlert
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: .alertTitle, message: .alertMessage, preferredStyle: .alert)
        let positive = UIAlertAction(title: .alertPositiveText, style: .default) { UIAlertAction in
            print(String.alertPositiveText)
        }
        let negative = UIAlertAction(title: .alertNegativeText, style: .default) { UIAlertAction in
            print(String.alertNegativeText)
        }
        
        alert.addAction(negative)
        alert.addAction(positive)

        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTitle()
        fetchOrbitalPeriod()
        setUp()
    }

    // MARK: Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func openAlert() {
        present(alert, animated: true, completion: nil)
    }

    private func setUp() {
        view.backgroundColor = .systemMint
        view.addSubview(infoView)

        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.topAnchor.constraint(equalTo: view.topAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchTitle() {
        guard let url = URL(string: .url) else { return }

        networkManager.request(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: [])

                    if let dictionary = object as? [[String: Any]] {
                        let title = dictionary.first?["title"] as? String ?? ""
                        self?.infoView.configureTitle(with: title)
                    }
                } catch let error {
                    print("🍎", error)
                }

            case .failure(let error):
                print("🍎", error)
            }
        }
    }

    private func fetchOrbitalPeriod() {
        guard let url = URL(string: .planetUrl) else { return }

        networkManager.request(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let planetData = try decoder.decode(PlanetModel.self, from: data)
                    let orbitalPeriod = planetData.orbitalPeriod
                    self?.infoView.configurePeriodTitle(with: orbitalPeriod)
                } catch let error {
                    print("🍎", error)
                }

            case .failure(let error):
                print("🍎", error)
            }
        }
    }
}

private extension String {
    static let alertTitle: String = "How are you today?"
    static let alertMessage: String = "Tracker of your mood"
    static let alertPositiveText: String = "I'am OK"
    static let alertNegativeText: String = "Not so good"

    static let url: String = "https://jsonplaceholder.typicode.com/todos/"
    static let planetUrl: String = "https://swapi.dev/api/planets/1"
}
