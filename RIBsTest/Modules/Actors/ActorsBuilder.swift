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

final class ActorsComponent: Component<ActorsDependency> {
    fileprivate var actorsViewController: ActorsViewControllable {
        return dependency.actorsViewController
    }
}

// MARK: - Builder

protocol ActorsBuildable: Buildable {
    func build(withListener listener: ActorsListener) -> ActorsRouting
}

final class ActorsBuilder: Builder<ActorsDependency>, ActorsBuildable {

    override init(dependency: ActorsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ActorsListener) -> ActorsRouting {
        let component = ActorsComponent(dependency: dependency)
        let interactor = ActorsInteractor(dataManager: dependency.dataManager)
        interactor.listener = listener
        
        let listBuildable = ListBuilder(dependency: dependency)
        let detailsNavigationBuildable = DetailsNavigationBuilder(dependency: dependency)
        
        return ActorsRouter(
            interactor: interactor,
            listBuildable: listBuildable,
            detailsNavigationBuildable: detailsNavigationBuildable,
            viewController: component.actorsViewController
        )
    }
}
