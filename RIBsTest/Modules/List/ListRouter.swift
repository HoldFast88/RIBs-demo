//
//  ListRouter.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 28.10.2021.
//

import RIBs

protocol ListInteractable: Interactable {
    var router: ListRouting? { get set }
    var listener: ListListener? { get set }
}

protocol ListViewControllable: ViewControllable {}

final class ListRouter: ViewableRouter<ListInteractable, ListViewControllable>, ListRouting {
    override init(interactor: ListInteractable, viewController: ListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
