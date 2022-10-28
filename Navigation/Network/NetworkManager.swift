//
//  NetworkManager.swift
//  Navigation
//
//  Created by m.khutornaya on 27.10.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func request(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class NetworkManager {

    private let mainQueue = DispatchQueue.main
}

extension NetworkManager: NetworkManagerProtocol {

    func request(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else {
                self.mainQueue.async { completion(.failure(.default)) }
                return
            }

            guard let data = data else {
                self.mainQueue.async { completion(.failure(.unknownError)) }
                return
            }

            self.mainQueue.async { completion(.success(data)) }
        })

        task.resume()
    }
}
