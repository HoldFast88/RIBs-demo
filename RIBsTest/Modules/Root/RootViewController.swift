//
//  RootViewController.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 27.10.2021.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    func didSelectMovies()
    func didSelectActors()
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    weak var listener: RootPresentableListener?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: view.bounds)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 24.0
        return stackView
    }()
    
    private lazy var moviesButton: UIButton = {
        let moviesButton = UIButton(type: .system)
        moviesButton.setTitle("Movies", for: .normal)
        moviesButton.addTarget(self, action: #selector(moviesAction), for: .touchUpInside)
        moviesButton.backgroundColor = .systemGray6
        return moviesButton
    }()
    
    private lazy var actorsButton: UIButton = {
        let actorsButton = UIButton(type: .system)
        actorsButton.setTitle("Actors", for: .normal)
        actorsButton.addTarget(self, action: #selector(actorsAction), for: .touchUpInside)
        actorsButton.backgroundColor = .systemGray6
        return actorsButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        stackView.addArrangedSubview(moviesButton)
        stackView.addArrangedSubview(actorsButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func moviesAction() {
        listener?.didSelectMovies()
    }
    
    @objc func actorsAction() {
        listener?.didSelectActors()
    }
    
    func present(_ viewControllable: ViewControllable) {
        present(viewControllable.uiviewController, animated: true)
    }
    
    func dismiss(_ viewControllable: ViewControllable) {
        viewControllable.uiviewController.dismiss(animated: true)
    }
}
