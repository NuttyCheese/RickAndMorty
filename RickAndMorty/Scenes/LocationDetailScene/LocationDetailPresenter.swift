//
//  LocationDetailPresenter.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import Foundation

protocol ILocationDetailPresenter {
    func pubish(data: LocationDetailModel.Response)
}

final class LocationDetailPresenter {
    weak var viewController: ILocationDetailView?
}

extension LocationDetailPresenter: ILocationDetailPresenter {
    func pubish(data: LocationDetailModel.Response) {
        
    }
}

private extension LocationDetailPresenter {
    
}
