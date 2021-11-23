//
//  RootInteractor.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 27.10.2021.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    func routeToMovies()
    func routeToActors()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
    weak var router: RootRouting?

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    func didSelectMovies() {
        router?.routeToMovies()
    }
    
    func didSelectActors() {
        router?.routeToActors()
    }
}
