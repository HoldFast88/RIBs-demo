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

protocol MovieDetailsViewControllable: ViewControllable {}

final class MovieDetailsRouter: ViewableRouter<MovieDetailsInteractable, MovieDetailsViewControllable>, MovieDetailsRouting {
    override init(interactor: MovieDetailsInteractable, viewController: MovieDetailsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
