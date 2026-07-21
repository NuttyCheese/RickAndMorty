//
//  EpisodeDetailInteractor.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import Foundation

protocol IEpisodeDetailInteractor {
    func loadData()
}

final class EpisodeDetailInteractor {
    private let presenter: IEpisodeDetailPresenter
    private let router: IEpisodeDetailRouter
    private let sectionManager: IEpisodeDetailSectionManager
    private let worker: IEpisodeDetailWorker
    private let identifier: Int
    
    private var sections = [EpisodeDetailModel.Response.EpisodeDetailSection]()
    
    init(
        presenter: IEpisodeDetailPresenter,
        router: IEpisodeDetailRouter,
        sectionManager: IEpisodeDetailSectionManager,
        worker: IEpisodeDetailWorker,
        identifier: Int
    ) {
        self.presenter = presenter
        self.router = router
        self.sectionManager = sectionManager
        self.worker = worker
        self.identifier = identifier
    }
}

extension EpisodeDetailInteractor: IEpisodeDetailInteractor {
    func loadData() {
        worker.fetchLoadData(identifier: identifier) { [weak self] episodeResult in
            guard let self else { return }
            print("\(#fileID) \(#function) \(#line) name = \(episodeResult?.name)")
        }
    }
}
