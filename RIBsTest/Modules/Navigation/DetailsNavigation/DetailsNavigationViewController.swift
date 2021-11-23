//
//  DetailsNavigationViewController.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs
import RxSwift
import UIKit

protocol DetailsNavigationPresentableListener: AnyObject {
    
}

final class DetailsNavigationViewController: UINavigationController, DetailsNavigationPresentable, DetailsNavigationViewControllable {
    weak var listener: DetailsNavigationPresentableListener?
    
    func set(_ viewControllables: [ViewControllable]) {
        viewControllers = viewControllables.compactMap { $0.uiviewController }
    }
    
    func show(_ viewControllable: ViewControllable) {
        pushViewController(viewControllable.uiviewController, animated: true)
    }
}
