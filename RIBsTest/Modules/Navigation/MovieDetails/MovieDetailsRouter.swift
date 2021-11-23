//
//  MovieDetailsRouter.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs

protocol MovieDetailsInteractable: Interactable {
    var router: MovieDetailsRouting? { get set }
    var listener: MovieDetailsListener? { get set }
}

protocol MovieDetailsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MovieDetailsRouter: ViewableRouter<MovieDetailsInteractable, MovieDetailsViewControllable>, MovieDetailsRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MovieDetailsInteractable, viewController: MovieDetailsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
