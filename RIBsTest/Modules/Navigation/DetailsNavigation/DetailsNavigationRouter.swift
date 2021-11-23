//
//  DetailsNavigationRouter.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs

protocol DetailsNavigationInteractable: Interactable, MovieDetailsListener, ActorDetailsListener {
    var router: DetailsNavigationRouting? { get set }
    var listener: DetailsNavigationListener? { get set }
}

protocol DetailsNavigationViewControllable: ViewControllable {
    func set(_ viewControllables: [ViewControllable])
    func show(_ viewControllable: ViewControllable)
}

final class DetailsNavigationRouter: ViewableRouter<DetailsNavigationInteractable, DetailsNavigationViewControllable>, DetailsNavigationRouting {
    private let movieDetailsBuildable: MovieDetailsBuildable
    private let actorDetailsBuildable: ActorDetailsBuildable
    
    init(interactor: DetailsNavigationInteractable, movieDetailsBuildable: MovieDetailsBuildable, actorDetailsBuildable: ActorDetailsBuildable, viewController: DetailsNavigationViewControllable) {
        self.movieDetailsBuildable = movieDetailsBuildable
        self.actorDetailsBuildable = actorDetailsBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func setMovieDetails(movie: Movie) {
        let movieDetailsRouting = movieDetailsBuildable.build(with: movie, and: interactor)
        attachChild(movieDetailsRouting)
        viewController.set([movieDetailsRouting.viewControllable])
    }
    
    func setActorDetails(actor: Actor) {
        let actorDetailsRouting = actorDetailsBuildable.build(with: actor, and: interactor)
        attachChild(actorDetailsRouting)
        viewController.set([actorDetailsRouting.viewControllable])
    }
    
    func routeToMovieDetails(movie: Movie) {
        let movieDetailsRouting = movieDetailsBuildable.build(with: movie, and: interactor)
        attachChild(movieDetailsRouting)
        viewController.show(movieDetailsRouting.viewControllable)
    }
    
    func routeToActorDetails(actor: Actor) {
        let actorDetailsRouting = actorDetailsBuildable.build(with: actor, and: interactor)
        attachChild(actorDetailsRouting)
        viewController.show(actorDetailsRouting.viewControllable)
    }
}
