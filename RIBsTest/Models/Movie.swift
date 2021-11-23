//
//  Movie.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 17.11.2021.
//

import UIKit

public struct Movie: Decodable {
    let id: String
    let title: String
    let actorsIds: [String]
    lazy var image: UIImage = InitialsImageFactory.imageWith(name: title) ?? UIImage()
}
