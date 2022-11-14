//
//  Post.swift
//  Navigation
//
//  Created by m.khutornaya on 14.11.2022.
//

import CoreData

extension Post {
    func updateLikes() {
        isLiked = !isLiked
        let increment = isLiked ? 1 : -1
        likes += Int32(increment)
        try? managedObjectContext?.save()
    }
}
