//
//  MoviesInteractor.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 28.10.2021.
//

import RIBs
import RxSwift

protocol MoviesRouting: Routing {
    func routeToList(items: [ListItem])
    func routeToDetails(for movie: Movie)
}

protocol MoviesListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MoviesInteractor: Interactor, MoviesInteractable {
    weak var router: MoviesRouting?
    weak var listener: MoviesListener?
    
    let dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        let listItems: [ListItem] = dataManager.movies
            .compactMap {
                var value = $0
                return ListItem(image: value.image, title: value.title)
            }
        router?.routeToList(items: listItems)
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension MoviesInteractor: ListListener {
    func listInteractorDidFinish(with selectedIndex: Int) {
        router?.routeToDetails(for: dataManager.movies[selectedIndex])
    }
}
