//
//  RootRouter.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 27.10.2021.
//

import RIBs

protocol RootInteractable: Interactable, MoviesListener, ActorsListener {
    var router: RootRouting? { get set }
}

protocol RootViewControllable: ActorsViewControllable, MoviesViewControllable {
    
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    private let moviesBuildable: MoviesBuildable
    private let actorsBuildable: ActorsBuildable
    
    init(moviesBuildable: MoviesBuildable, actorsBuildable: ActorsBuildable, interactor: RootInteractable, viewController: RootViewControllable) {
        self.moviesBuildable = moviesBuildable
        self.actorsBuildable = actorsBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToMovies() {
        let moviesRouting = moviesBuildable.build(withListener: interactor)
        attachChild(moviesRouting)
    }
    
    func routeToActors() {
        let actorsRouting = actorsBuildable.build(withListener: interactor)
        attachChild(actorsRouting)
    }
}
