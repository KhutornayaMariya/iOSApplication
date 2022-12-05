//
//  InfoViewController.swift
//  Navigation
//
//  Created by Mariia Khutornaia on 20.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    var networkManager: NetworkManagerProtocol = NetworkManager()
    var residentUrls: [String] = []
    
    private lazy var infoView: InfoView = {
        let view = InfoView()
        
        view.onTapButtonHandler = openAlert
        view.onTapResidentsButtonHandler = openPlanetResidentsViewController
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: "MOOD_ALERT_TITLE".localized, message: "MOOD_ALERT_MESSAGE".localized, preferredStyle: .alert)
        let positive = UIAlertAction(title: "GOOD_MOOD".localized, style: .default) { UIAlertAction in
            print("GOOD_MOOD".localized)
        }
        let negative = UIAlertAction(title: "BAD_MOOD".localized, style: .default) { UIAlertAction in
            print("BAD_MOOD".localized)
        }
        
        alert.addAction(negative)
        alert.addAction(positive)
        
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTitle()
        fetchPlanetData()
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
    
    @objc
    func openPlanetResidentsViewController() {
        present(PlanetResidentsViewController(model: PlanetResidentsModel(urls: residentUrls)), animated: true, completion: nil)
    }
    
    private func setUp() {
        view.backgroundColor = .systemBackground
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
    
    private func fetchPlanetData() {
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
                    self?.residentUrls = planetData.residents
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
    static let url: String = "https://jsonplaceholder.typicode.com/todos/"
    static let planetUrl: String = "https://swapi.dev/api/planets/1"
}
