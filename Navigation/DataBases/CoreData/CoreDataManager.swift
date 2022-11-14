//
//  CoreDataManager.swift
//  Navigation
//
//  Created by m.khutornaya on 10.11.2022.
//

import Foundation
import CoreData

final class CoreDataManager {

    static let defaultManager = CoreDataManager()

    var posts: [Post] = []

    init() {
        reloadPosts()
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Data")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func reloadPosts() {
        let request = Post.fetchRequest()
        do {
            self.posts = try self.persistentContainer.viewContext.fetch(request)
        }
        catch {
            print("Error")
        }
    }
}

extension CoreDataManager: CoreDataManagerProtocol {

    func addPost(_ post: PostModel) {
        let newPost = Post(context: persistentContainer.viewContext)
        newPost.postDescription = post.description
        newPost.author = post.author
        newPost.image = post.image
        newPost.likes = Int32(post.likes)
        newPost.views = Int32(post.views)
        newPost.isLiked = post.isLiked
        saveContext()
        reloadPosts()
    }

    func deletePost(_ post: PostModel) {
        let postToDelete = posts.first(where: { $0.postDescription == post.description })
        guard let postToDelete = postToDelete else {
            return
        }
        persistentContainer.viewContext.delete(postToDelete)
        saveContext()
        reloadPosts()
    }

    func getLikedPosts() -> [Post] {
        posts.filter { $0.isLiked == true }
    }
}
