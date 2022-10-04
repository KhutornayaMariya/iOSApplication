//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by m.khutornaya on 04.10.2022.
//

final class ProfileViewModel {

    let user: User
    let dataItems: [PostModel]

    init(user: User) {
        self.user = user
        self.dataItems = ProfileRepository().postItems
    }
}
