//
//  LocationDetailInteractor.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import Foundation

protocol ILocationDetailInteractor {
    func loadData()
}

final class LocationDetailInteractor {
    private let presenter: ILocationDetailPresenter!
    private let router: ILocationDetailRouter!
    private let worker: ILocationDetailWorker!
    private let sectionManager: ILocationDetailSectionManager!
    private let identifier: Int!
    
    private var sections = [LocationDetailModel.Response.LocationDetailSection]()
    
    init(
        presenter: ILocationDetailPresenter!,
        router: ILocationDetailRouter!,
        worker: ILocationDetailWorker!,
        sectionManager: ILocationDetailSectionManager!,
        identifier: Int!
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.sectionManager = sectionManager
        self.identifier = identifier
    }
}

extension LocationDetailInteractor: ILocationDetailInteractor {
    func loadData() {
        
    }
}

private extension LocationDetailInteractor {
    
}
