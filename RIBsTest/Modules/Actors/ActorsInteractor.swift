//
//  ActorsInteractor.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 28.10.2021.
//

import RIBs
import RxSwift

protocol ActorsRouting: Routing {
    func routeToList(items: [ListItem])
    func routeToDetails(for actor: Actor)
}

protocol ActorsListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ActorsInteractor: Interactor, ActorsInteractable {
    weak var router: ActorsRouting?
    weak var listener: ActorsListener?
    
    private let dataManager: DataManager
    private var listItems: [ListItem]?

    init(dataManager: DataManager) {
        self.dataManager = dataManager
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        let listItems: [ListItem] = dataManager.actors
            .compactMap {
                var value = $0
                return ListItem(image: value.image, title: value.name)
            }
        self.listItems = listItems
        router?.routeToList(items: listItems)
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension ActorsInteractor: ListListener {
    func listInteractorDidFinish(with selectedIndex: Int) {
        router?.routeToDetails(for: dataManager.actors[selectedIndex])
    }
}
