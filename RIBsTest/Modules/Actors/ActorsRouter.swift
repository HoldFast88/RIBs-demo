//
//  ActorsRouter.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 28.10.2021.
//

import RIBs

protocol ActorsInteractable: Interactable, ListListener, DetailsNavigationListener {
    var router: ActorsRouting? { get set }
    var listener: ActorsListener? { get set }
}

protocol ActorsViewControllable: ViewControllable {
    func present(_ viewControllable: ViewControllable)
    func dismiss(_ viewControllable: ViewControllable)
}

final class ActorsRouter: Router<ActorsInteractable>, ActorsRouting {
    private let viewController: ActorsViewControllable
    private let listBuildable: ListBuildable
    private let detailsNavigationBuildable: DetailsNavigationBuildable
    private var listRouting: ListRouting?
    private var detailsNavigationRouting: DetailsNavigationRouting?
    
    init(interactor: ActorsInteractable, listBuildable: ListBuildable, detailsNavigationBuildable: DetailsNavigationBuildable, viewController: ActorsViewControllable) {
        self.viewController = viewController
        self.listBuildable = listBuildable
        self.detailsNavigationBuildable = detailsNavigationBuildable
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    func routeToList(items: [ListItem]) {
        let listRouting = listBuildable.build(with: items, title: "Movies", listener: interactor)
        viewController.present(listRouting.viewControllable)
        attachChild(listRouting)
        self.listRouting = listRouting
    }
    
    func routeToDetails(for actor: Actor) {
        cleanupViews()
        let detailsNavigationRouting = detailsNavigationBuildable.build(with: .actor(actor), and: interactor)
        viewController.present(detailsNavigationRouting.viewControllable)
        attachChild(detailsNavigationRouting)
        self.detailsNavigationRouting = detailsNavigationRouting
    }

    func cleanupViews() {
        if let listRouting = listRouting {
            detachChild(listRouting)
            viewController.dismiss(listRouting.viewControllable)
        }
        if let detailsNavigationRouting = detailsNavigationRouting {
            detachChild(detailsNavigationRouting)
            viewController.dismiss(detailsNavigationRouting.viewControllable)
        }
    }
}
