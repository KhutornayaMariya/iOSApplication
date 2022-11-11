//
//  CoreDataManagerProtocol.swift
//  Navigation
//
//  Created by m.khutornaya on 11.11.2022.
//

import Foundation

protocol CoreDataManagerProtocol {
    func addPost(_ post: PostModel)
    func deletePost(_ post: PostModel)
    func getLikedPosts() -> [Post]
}
