//
//  ProfileRepository.swift
//  Navigation
//
//  Created by m.khutornaya on 23.07.2022.
//

import UIKit

struct ProfileRepository {
    let postItems: [PostModel] = [
        PostModel(author: "Vitalii", description: "I am so happy!", image: "1", likes: 3, views: 122),
        PostModel(author: "Timur", description: "Hello everyone!", image: "2", likes: 33, views: 54),
        PostModel(author: "Larisa", description: "welcome to my board", image: "3", likes: 23, views: 90),
        PostModel(author: "Ura", description: "Hahahaah lol", image: "4", likes: 13, views: 13),
        PostModel(author: "Nikolay",
                  description: "Autumn is here, and that means the risk of hitting deer on rural roads and highways is rising, especially around dusk and during a full moon.\nDeer cause over 1 million motor vehicle accidents in the U.S. each year, resulting in more than US$1 billion in property damage, about 200 human deaths and 29,000 serious injuries. Property damage insurance claims average around $2,600 per accident, and the overall average cost, including severe injuries or death, is over $6,000.\nWhile avoiding deer – as well as moose, elk and other hoofed animals, known as ungulates – can seem impossible if you’re driving in rural areas, there are certain times and places that are most hazardous, and so warrant extra caution.",
                  image: "5",
                  likes: 9,
                  views: 55)
    ]

    let photoItems: [UIImage] = [UIImage(named: "one")!,
                                UIImage(named: "two")!,
                                UIImage(named: "three")!,
                                UIImage(named: "four")!,
                                UIImage(named: "five")!,
                                UIImage(named: "six")!,
                                UIImage(named: "seven")!,
                                UIImage(named: "eight")!,
                                UIImage(named: "nine")!,
                                UIImage(named: "ten")!,
                                UIImage(named: "eleven")!,
                                UIImage(named: "twelve")!,
                                UIImage(named: "thirteen")!,
                                UIImage(named: "fourteen")!,
                                UIImage(named: "fifteen")!,
                                UIImage(named: "sixteen")!,
                                UIImage(named: "seventeen")!,
                                UIImage(named: "eighteen")!,
                                UIImage(named: "nineteen")!,
                                UIImage(named: "twenty")!]
}
