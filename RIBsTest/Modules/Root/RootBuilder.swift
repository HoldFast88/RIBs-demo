//
//  RootBuilder.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 27.10.2021.
//

import RIBs

protocol RootDependency: MoviesDependency, ActorsDependency {
    var viewController: RootViewController { get }
}

final class RootComponent: Component<EmptyDependency>, RootDependency {
    var viewController: RootViewController = RootViewController()
    
    var moviesViewController: MoviesViewControllable {
        viewController
    }
    
    var actorsViewController: ActorsViewControllable {
        viewController
    }
    
    var dataManager: DataManager = DataManager()
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let interactor = RootInteractor(presenter: dependency.viewController)
        
        let moviesBuildable = MoviesBuilder(dependency: dependency)
        let actorsBuildable = ActorsBuilder(dependency: dependency)
        
        return RootRouter(
            moviesBuildable: moviesBuildable,
            actorsBuildable: actorsBuildable,
            interactor: interactor,
            viewController: dependency.viewController
        )
    }
}
