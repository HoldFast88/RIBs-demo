//
//  ActorDetailsInteractor.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs
import RxSwift

protocol ActorDetailsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ActorDetailsPresentable: Presentable {
    var listener: ActorDetailsPresentableListener? { get set }
    func configure(with actor: Actor, movies: [Movie])
}

protocol ActorDetailsListener: AnyObject {
    func actorDetailsInteractorDidFinish(with movie: Movie)
}

final class ActorDetailsInteractor: PresentableInteractor<ActorDetailsPresentable>, ActorDetailsInteractable, ActorDetailsPresentableListener {
    weak var router: ActorDetailsRouting?
    weak var listener: ActorDetailsListener?
    
    private let actor: Actor
    private let dataManager: DataManager

    init(actor: Actor, dataManager: DataManager, presenter: ActorDetailsPresentable) {
        self.actor = actor
        self.dataManager = dataManager
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        let movies = actor.moviesIds.compactMap { dataManager.movie(with: $0) }
        presenter.configure(with: actor, movies: movies)
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didSelectItem(at index: Int) {
        let movies = actor.moviesIds.compactMap { dataManager.movie(with: $0) }
        listener?.actorDetailsInteractorDidFinish(with: movies[index])
    }
}
