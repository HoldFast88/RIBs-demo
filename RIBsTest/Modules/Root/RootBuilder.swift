//
//  RootBuilder.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 27.10.2021.
//

import RIBs

protocol RootDependency: MoviesDependency, ActorsDependency {
    var dataManager: DataManager { get }
}

final class RootComponent: Component<RootDependency> {
    private let rootViewController: RootViewController
    
    init(dependency: RootDependency, rootViewController: RootViewController) {
        self.rootViewController = rootViewController
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
