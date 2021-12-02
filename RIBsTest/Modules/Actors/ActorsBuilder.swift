//
//  ActorsBuilder.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 28.10.2021.
//

import RIBs

protocol ActorsDependency: ListDependency, DetailsNavigationDependency {
    var dataManager: DataManager { get }
    var actorsViewController: ActorsViewControllable { get }
}

final class ActorsComponent: Component<ActorsDependency> {}

// MARK: - Builder

protocol ActorsBuildable: Buildable {
    func build(withListener listener: ActorsListener) -> ActorsRouting
}

final class ActorsBuilder: Builder<ActorsDependency>, ActorsBuildable {
    override init(dependency: ActorsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ActorsListener) -> ActorsRouting {
        let interactor = ActorsInteractor(dataManager: dependency.dataManager)
        interactor.listener = listener
        
        let listBuildable = ListBuilder(dependency: dependency)
        let detailsNavigationBuildable = DetailsNavigationBuilder(dependency: dependency)
        
        return ActorsRouter(
            interactor: interactor,
            listBuildable: listBuildable,
            detailsNavigationBuildable: detailsNavigationBuildable,
            viewController: dependency.actorsViewController
        )
    }
}
