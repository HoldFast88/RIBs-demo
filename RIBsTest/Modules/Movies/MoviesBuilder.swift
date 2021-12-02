//
//  MoviesBuilder.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 28.10.2021.
//

import RIBs

protocol MoviesDependency: ListDependency, DetailsNavigationDependency {
    var dataManager: DataManager { get }
    var moviesViewController: MoviesViewControllable { get }
}

final class MoviesComponent: Component<MoviesDependency> {}

// MARK: - Builder

protocol MoviesBuildable: Buildable {
    func build(withListener listener: MoviesListener) -> MoviesRouting
}

final class MoviesBuilder: Builder<MoviesDependency>, MoviesBuildable {
    override init(dependency: MoviesDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MoviesListener) -> MoviesRouting {
        let interactor = MoviesInteractor(dataManager: dependency.dataManager)
        interactor.listener = listener
        
        let listBuildable = ListBuilder(dependency: dependency)
        let detailsNavigationBuildable = DetailsNavigationBuilder(dependency: dependency)
        
        return MoviesRouter(
            interactor: interactor,
            listBuildable: listBuildable,
            detailsNavigationBuildable: detailsNavigationBuildable,
            viewController: dependency.moviesViewController
        )
    }
}
