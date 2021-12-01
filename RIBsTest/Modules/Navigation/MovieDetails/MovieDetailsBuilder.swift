//
//  MovieDetailsBuilder.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs

protocol MovieDetailsDependency: Dependency {
    var dataManager: DataManager { get }
}

final class MovieDetailsComponent: Component<MovieDetailsDependency> {}

// MARK: - Builder

protocol MovieDetailsBuildable: Buildable {
    func build(with movie: Movie, and listener: MovieDetailsListener) -> MovieDetailsRouting
}

final class MovieDetailsBuilder: Builder<MovieDetailsDependency>, MovieDetailsBuildable {

    override init(dependency: MovieDetailsDependency) {
        super.init(dependency: dependency)
    }

    func build(with movie: Movie, and listener: MovieDetailsListener) -> MovieDetailsRouting {
        let viewController = MovieDetailsViewController()
        let interactor = MovieDetailsInteractor(
            movie: movie,
            dataManager: dependency.dataManager,
            presenter: viewController
        )
        interactor.listener = listener
        return MovieDetailsRouter(interactor: interactor, viewController: viewController)
    }
}
