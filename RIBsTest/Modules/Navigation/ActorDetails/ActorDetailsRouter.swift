//
//  ActorDetailsRouter.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs

protocol ActorDetailsInteractable: Interactable {
    var router: ActorDetailsRouting? { get set }
    var listener: ActorDetailsListener? { get set }
}

protocol ActorDetailsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ActorDetailsRouter: ViewableRouter<ActorDetailsInteractable, ActorDetailsViewControllable>, ActorDetailsRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ActorDetailsInteractable, viewController: ActorDetailsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
