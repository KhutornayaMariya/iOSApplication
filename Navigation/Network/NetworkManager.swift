//
//  NetworkManager.swift
//  Navigation
//
//  Created by m.khutornaya on 27.10.2022.
//

import Foundation

struct NetworkManager {

    static func request(for configuration: AppConfiguration) {
        guard let url = configuration.url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print("data: \(String(data: data, encoding: .utf8) ?? "") \n")
            }

            if let response = response as? HTTPURLResponse {
                print("response.statusCode: \(response.statusCode) \n")
                print("response.allHeaderFields: \(response.allHeaderFields)")
            }

            if let error = error {
                print("error: \(error.localizedDescription)")
//            error: The Internet connection appears to be offline.
            }
        }

        task.resume()
    }
}
