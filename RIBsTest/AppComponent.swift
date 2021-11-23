//
//  AppComponent.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 27.10.2021.
//

import RIBs

final class AppComponent: Component<EmptyDependency>, RootDependency {
    var moviesViewController: MoviesViewControllable
    var actorsViewController: ActorsViewControllable
    
    var dataManager: DataManager {
        shared { DataManager() }
    }
    
    init(dependency: EmptyDependency, moviesViewController: MoviesViewControllable, actorsViewController: ActorsViewControllable) {
        self.moviesViewController = moviesViewController
        self.actorsViewController = actorsViewController
        super.init(dependency: dependency)
    }
}
