//
//  MainInteractor.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

protocol IMainInteractor {
    func loadData()
}

final class MainInteractor {
    private let router: IMainRouter
    private let presenter: IMainPresenter
    private let worker: IMainWorker
    private let sectionManager: IMainSectionManager
    
    private var sections = [MainModel.Response.MainSection]()
    init(
        router: IMainRouter,
        presenter: IMainPresenter,
        worker: IMainWorker,
        sectionManager: IMainSectionManager
    ) {
        self.router = router
        self.presenter = presenter
        self.worker = worker
        self.sectionManager = sectionManager
    }
}

extension MainInteractor: IMainInteractor {
    func loadData() {
        worker.loadCharacters(page: 1) { [weak self] charaters in
            guard let self else { return }
            
            let charSection = sectionManager.createCharactersSection(
                characters: charaters) { [weak self] id in
                    guard let self else { return }
                    router.transitionById(from: id)
                }
            
            sections.append(charSection)
            
            self.presenter.publish(data: MainModel.Response(data: sections))
        }
    }
}
