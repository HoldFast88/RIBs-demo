//
//  Actor.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 17.11.2021.
//

import UIKit

public struct Actor: Decodable {
    let id: String
    let name: String
    let moviesIds: [String]
    lazy var image: UIImage = InitialsImageFactory.imageWith(name: name) ?? UIImage()
}
