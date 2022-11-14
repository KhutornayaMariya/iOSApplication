//
//  PostModelFactory.swift
//  Navigation
//
//  Created by m.khutornaya on 11.11.2022.
//

import Foundation

final class PostModelFactory {

    let postModel: PostModel

    init(_ post: Post) {
        self.postModel = PostModel(author: post.author!,
                                   description: post.postDescription!,
                                   image: post.image!,
                                   likes: Int(post.likes),
                                   views: Int(post.views),
                                   isLiked: post.isLiked)
    }
}
