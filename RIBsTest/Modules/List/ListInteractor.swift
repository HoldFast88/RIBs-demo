//
//  ListInteractor.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 28.10.2021.
//

import RIBs
import RxSwift

protocol ListRouting: ViewableRouting {}

protocol ListPresentable: Presentable {
    var listener: ListPresentableListener? { get set }
    func present(items: [ListItem])
}

protocol ListListener: AnyObject {
    func listInteractorDidFinish(with selectedIndex: Int)
}

final class ListInteractor: PresentableInteractor<ListPresentable>, ListInteractable, ListPresentableListener {
    weak var router: ListRouting?
    weak var listener: ListListener?
    
    private let items: [ListItem]

    init(items: [ListItem], presenter: ListPresentable) {
        self.items = items
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.present(items: items)
    }
    
    func didSelectItem(at index: Int) {
        listener?.listInteractorDidFinish(with: index)
    }
}
