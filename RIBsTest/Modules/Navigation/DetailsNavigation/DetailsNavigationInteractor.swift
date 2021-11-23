//
//  DetailsNavigationInteractor.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs
import RxSwift

protocol DetailsNavigationRouting: ViewableRouting {
    func setMovieDetails(movie: Movie)
    func setActorDetails(actor: Actor)
    func routeToMovieDetails(movie: Movie)
    func routeToActorDetails(actor: Actor)
}

protocol DetailsNavigationPresentable: Presentable {
    var listener: DetailsNavigationPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DetailsNavigationListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DetailsNavigationInteractor: PresentableInteractor<DetailsNavigationPresentable>, DetailsNavigationInteractable, DetailsNavigationPresentableListener {
    weak var router: DetailsNavigationRouting?
    weak var listener: DetailsNavigationListener?
    
    private let payload: DetailsNavigationPayload

    init(payload: DetailsNavigationPayload, presenter: DetailsNavigationPresentable) {
        self.payload = payload
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        switch payload {
        case let .movie(movie):
            router?.setMovieDetails(movie: movie)
        case let .actor(actor):
            router?.setActorDetails(actor: actor)
        }
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func movieDetailsInteractorDidFinish(with actor: Actor) {
        router?.routeToActorDetails(actor: actor)
    }
    
    func actorDetailsInteractorDidFinish(with movie: Movie) {
        router?.routeToMovieDetails(movie: movie)
    }
}
