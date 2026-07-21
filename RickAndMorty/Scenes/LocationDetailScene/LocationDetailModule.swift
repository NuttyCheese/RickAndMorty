//
//  LocationDetailModule.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import UIKit

enum LocationDetailModule {
    static func build(identifier: Int) -> UIViewController {
        let view = LocationDetailViewController()
        let presenter = LocationDetailPresenter()
        let router = LocationDetailRouter()
        let sectionManager = LocationDetailSectionManager()
        let worker = LocationDetailWorker()
        let interactor = LocationDetailInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            sectionManager: sectionManager,
            identifier: identifier
        )
        
        view.interactor = interactor
        presenter.viewController = view
        router.transitionHandler = view
        
        return view
    }
}
