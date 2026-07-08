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
    private let secionManager: IMainSectionManager
    
    init(
        router: IMainRouter,
        presenter: IMainPresenter,
        worker: IMainWorker,
        secionManager: IMainSectionManager
    ) {
        self.router = router
        self.presenter = presenter
        self.worker = worker
        self.secionManager = secionManager
    }
}

extension MainInteractor: IMainInteractor {
    func loadData() {
        
    }
}
