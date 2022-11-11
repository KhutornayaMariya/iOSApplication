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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func reloadPosts() {
        let request = Post.fetchRequest()
        do {
            self.posts = try self.persistentContainer.viewContext.fetch(request)
            print(self.posts)
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
