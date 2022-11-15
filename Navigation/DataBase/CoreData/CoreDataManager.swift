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
            print(error)
        }
    }

    private func fillCoreDataWithPosts() {
        for post in ProfileRepository().postItems {
            addPost(post)
        }
    }
}

extension CoreDataManager {

    func addPost(_ post: PostModel) {
        persistentContainer.performBackgroundTask { context in
            let newPost = Post(context: context)
            newPost.postDescription = post.description
            newPost.author = post.author
            newPost.image = post.image
            newPost.likes = Int32(post.likes)
            newPost.views = Int32(post.views)
            newPost.isLiked = post.isLiked

            do {
                try context.save()
                print("Пост добавлен")
            } catch {
                print(error)
            }
        }
    }

    func deletePost(_ post: Post) {
        persistentContainer.viewContext.delete(post)
        saveContext()
    }

    func getLikedPosts() -> NSFetchedResultsController<Post> {
        let request = Post.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: false)]
        request.predicate = NSPredicate(format: "isLiked == true")
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: persistentContainer.viewContext,
                                             sectionNameKeyPath: nil, cacheName: nil)
        do {
            try frc.performFetch()
        }
        catch {
           print(error)
        }
        return frc
    }

    func searchPosts(with author: String) -> NSFetchedResultsController<Post> {
        let request = Post.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: false)]
        request.predicate = NSPredicate(format: "(author contains[c] %@) AND (isLiked == true)", author)
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: persistentContainer.viewContext,
                                             sectionNameKeyPath: nil, cacheName: nil)
        do {
            try frc.performFetch()
        }
        catch {
           print(error)
        }
        return frc
    }
}
