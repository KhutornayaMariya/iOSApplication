//
//  FeedModel.swift
//  Navigation
//
//  Created by m.khutornaya on 03.10.2022.
//

struct FeedModel {
    private let word: String = "Secret"

    func check(_ word:String) -> Bool {
        return word == self.word
    }
}
