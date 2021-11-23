//
//  MovieDetailsInteractor.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs
import RxSwift

protocol MovieDetailsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MovieDetailsPresentable: Presentable {
    var listener: MovieDetailsPresentableListener? { get set }
    func configure(with movie: Movie, actors: [Actor])
}

protocol MovieDetailsListener: AnyObject {
    func movieDetailsInteractorDidFinish(with actor: Actor)
}

final class MovieDetailsInteractor: PresentableInteractor<MovieDetailsPresentable>, MovieDetailsInteractable, MovieDetailsPresentableListener {
    weak var router: MovieDetailsRouting?
    weak var listener: MovieDetailsListener?

    private let movie: Movie
    private let dataManager: DataManager
    
    init(movie: Movie, dataManager: DataManager, presenter: MovieDetailsPresentable) {
        self.movie = movie
        self.dataManager = dataManager
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        let actors = movie.actorsIds.compactMap { dataManager.actor(with: $0) }
        presenter.configure(with: movie, actors: actors)
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didSelectItem(at index: Int) {
        let actors = movie.actorsIds.compactMap { dataManager.actor(with: $0) }
        listener?.movieDetailsInteractorDidFinish(with: actors[index])
    }
}
