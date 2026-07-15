//
//  EpisodeDetailModule.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import UIKit

enum EpisodeDetailModule {
    static func build(identifier: Int) -> UIViewController {
        let view = EpisodeDetailViewController()
        let presenter = EpisodeDetailPresenter()
        let router = EpisodeDetailRouter()
        let worker = EpisodeDetailWorker()
        let sectionManager = EpisodeDetailSectionManager()
        let interactor = EpisodeDetailInteractor(
            presenter: presenter,
            router: router,
            sectionManager: sectionManager,
            worker: worker,
            identifier: identifier
        )
        
        view.interactor = interactor
        presenter.viewController = view
        router.transitionHandler = view
        
        return view
    }
}
