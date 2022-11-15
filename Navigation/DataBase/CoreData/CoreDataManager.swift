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
        if posts.isEmpty {
            fillCoreDataWithPosts()
        }
    }

    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()

    private lazy var persistentContainer: NSPersistentContainer = {
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
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
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

    private func fillCoreDataWithPosts() {
        for post in ProfileRepository().postItems {
            addPost(post)
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
        posts.append(newPost)
        saveContext()
    }

    func deletePost(_ post: PostModel) {
        let index = posts.firstIndex(where: { $0.postDescription == post.description })
        guard let index = index else {
            return
        }
        persistentContainer.viewContext.delete(posts[index])
        posts.remove(at: index)
        saveContext()
    }

    func getLikedPosts() -> [Post] {
        posts.filter { $0.isLiked == true }
    }
}
