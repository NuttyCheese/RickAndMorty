//
//  CharacterDetailModule.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import UIKit

enum CharacterDetailModule {
    static func build(id: Int) -> UIViewController {
        let view = CharacterDetailViewController()
        let presenter = CharacterDetailPresenter()
        let router = CharacterDetailRouter()
        let worket = CharacterDetailWorker()
        let sectionManager = CharacterDetailSectionManager()
        let interactor = CharacterDetailInteractor(
            presenter: presenter,
            router: router,
            worker: worket,
            sectionManager: sectionManager,
            identifier: id
        )
        
        view.interactor = interactor
        presenter.viewController = view
        router.transitionView = view
        
        return view
    }
}
