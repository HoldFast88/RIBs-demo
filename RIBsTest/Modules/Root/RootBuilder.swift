//
//  RootBuilder.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 27.10.2021.
//

import RIBs

protocol RootDependency: MoviesDependency, ActorsDependency {}

final class RootComponent: Component<EmptyDependency>, RootDependency {
    var moviesViewController: MoviesViewControllable
    var actorsViewController: ActorsViewControllable
    
    var dataManager: DataManager {
        shared { DataManager() }
    }
    
    init(dependency: EmptyDependency, moviesViewController: MoviesViewControllable, actorsViewController: ActorsViewControllable) {
        self.moviesViewController = moviesViewController
        self.actorsViewController = actorsViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build(_ viewControllable: RootViewController) -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build(_ viewControllable: RootViewController) -> LaunchRouting {
        let interactor = RootInteractor(presenter: viewControllable)
        
        let moviesBuildable = MoviesBuilder(dependency: dependency)
        let actorsBuildable = ActorsBuilder(dependency: dependency)
        
        return RootRouter(
            moviesBuildable: moviesBuildable,
            actorsBuildable: actorsBuildable,
            interactor: interactor,
            viewController: viewControllable
        )
    }
}
