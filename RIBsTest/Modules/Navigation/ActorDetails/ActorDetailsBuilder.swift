//
//  ActorDetailsBuilder.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs

protocol ActorDetailsDependency: Dependency {
    var dataManager: DataManager { get }
}

final class ActorDetailsComponent: Component<ActorDetailsDependency> {}

// MARK: - Builder

protocol ActorDetailsBuildable: Buildable {
    func build(with actor: Actor, and listener: ActorDetailsListener) -> ActorDetailsRouting
}

final class ActorDetailsBuilder: Builder<ActorDetailsDependency>, ActorDetailsBuildable {

    override init(dependency: ActorDetailsDependency) {
        super.init(dependency: dependency)
    }

    func build(with actor: Actor, and listener: ActorDetailsListener) -> ActorDetailsRouting {
        let viewController = ActorDetailsViewController()
        let interactor = ActorDetailsInteractor(
            actor: actor,
            dataManager: dependency.dataManager,
            presenter: viewController
        )
        interactor.listener = listener
        return ActorDetailsRouter(interactor: interactor, viewController: viewController)
    }
}
