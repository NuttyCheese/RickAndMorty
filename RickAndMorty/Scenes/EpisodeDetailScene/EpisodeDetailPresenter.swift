//
//  EpisodeDetailPresenter.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import Foundation

protocol IEpisodeDetailPresenter {
    func publish(data: EpisodeDetailModel.Response)
}

final class EpisodeDetailPresenter {
    weak var viewController: IEpisodeDetailView?
}

extension EpisodeDetailPresenter: IEpisodeDetailPresenter {
    func publish(data: EpisodeDetailModel.Response) {
        
    }
}

private extension EpisodeDetailPresenter {
    
}
