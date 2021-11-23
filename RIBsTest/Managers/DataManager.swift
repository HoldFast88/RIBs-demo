//
//  DataManager.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 17.11.2021.
//

import UIKit

final class DataManager {
    private struct FailableDecodable<Base: Decodable>: Decodable {
        let base: Base?

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.base = try? container.decode(Base.self)
        }
    }
    
    public let movies: [Movie]
    public let actors: [Actor]
    
    init() {
        guard
            let moviesListURL = Bundle.main.url(forResource: "Movies", withExtension: "json"),
            let actorsListURL = Bundle.main.url(forResource: "Actors", withExtension: "json"),
            let moviesData = try? Data(contentsOf: moviesListURL),
            let actorsData = try? Data(contentsOf: actorsListURL)
        else { fatalError() }
        
        let decoder = JSONDecoder()
        movies = try! decoder
            .decode([FailableDecodable<Movie>].self, from: moviesData)
            .compactMap { $0.base }
        actors = try! decoder
            .decode([FailableDecodable<Actor>].self, from: actorsData)
            .compactMap { $0.base }
    }
    
    public func actor(with id: String) -> Actor? {
        return actors.first { $0.id == id }
    }
    
    public func movie(with id: String) -> Movie? {
        return movies.first { $0.id == id }
    }
}
