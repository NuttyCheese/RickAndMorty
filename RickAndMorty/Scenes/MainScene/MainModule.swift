//
//  MainModule.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import UIKit

enum MainModule {
    static func build() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter()
        let router = MainRouter()
        let worker = MainWorker()
        let sectionManager = MainSectionManager()
        let interactor = MainInteractor(
            router: router,
            presenter: presenter,
            worker: worker,
            sectionManager: sectionManager
        )
        
        view.interactor = interactor
        presenter.viewController = view
        router.transitionHandler = view
        
        return view
    }
}
