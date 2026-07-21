//
//  LocationDetailWorker.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import Foundation

protocol ILocationDetailWorker {
    func fetchLoadData(identifier: Int, completion: @escaping(LocationDTO?) -> ())
}

final class LocationDetailWorker {
    private let dataSource = RMDataSourceRemote()
}

extension LocationDetailWorker: ILocationDetailWorker {
    func fetchLoadData(identifier: Int, completion: @escaping (LocationDTO?) -> ()) {
        fetchData(identifier: identifier, completion: completion)
    }
}

private extension LocationDetailWorker {
    func fetchData(identifier: Int, completion: @escaping(LocationDTO?) -> ()) {
        dataSource.getLocation(id: identifier) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                completion(nil)
            }
        }
    }
}
