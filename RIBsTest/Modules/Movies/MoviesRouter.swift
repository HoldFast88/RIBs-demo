//
//  MoviesRouter.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 28.10.2021.
//

import RIBs

protocol MoviesInteractable: Interactable, ListListener, DetailsNavigationListener {
    var router: MoviesRouting? { get set }
    var listener: MoviesListener? { get set }
}

protocol MoviesViewControllable: ViewControllable {
    func present(_ viewControllable: ViewControllable)
    func dismiss(_ viewControllable: ViewControllable)
}

final class MoviesRouter: Router<MoviesInteractable>, MoviesRouting {
    private let viewController: MoviesViewControllable
    private let listBuildable: ListBuildable
    private let detailsNavigationBuildable: DetailsNavigationBuildable
    private var listRouting: ListRouting?
    private var detailsNavigationRouting: DetailsNavigationRouting?
    
    init(interactor: MoviesInteractable, listBuildable: ListBuildable, detailsNavigationBuildable: DetailsNavigationBuildable, viewController: MoviesViewControllable) {
        self.listBuildable = listBuildable
        self.detailsNavigationBuildable = detailsNavigationBuildable
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    func routeToList(items: [ListItem]) {
        let listRouting = listBuildable.build(with: items, title: "Movies", listener: interactor)
        viewController.present(listRouting.viewControllable)
        attachChild(listRouting)
        self.listRouting = listRouting
    }
    
    func routeToDetails(for movie: Movie) {
        cleanupViews()
        let detailsNavigationRouting = detailsNavigationBuildable.build(with: .movie(movie), and: interactor)
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
