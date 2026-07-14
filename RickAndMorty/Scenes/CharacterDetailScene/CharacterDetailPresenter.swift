//
//  CharacterDetailPresenter.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import Foundation

protocol ICharacterDetailPresenter {
    func publish(data: CharacterDetailModel.Response)
}

final class CharacterDetailPresenter {
    weak var viewController: ICharacterDetailView?
}

extension CharacterDetailPresenter: ICharacterDetailPresenter {
    func publish(data: CharacterDetailModel.Response) {
        let sectionViewModel = data.data.map(mapData)
        viewController?.update(sections: sectionViewModel)
    }
}

private extension CharacterDetailPresenter {
    func mapData(_ section: CharacterDetailModel.Response.CharacterDetailSection) -> SectionViewModel {
        SectionViewModel(title: section.section.text, viewModels: section.items.map(mapData))
    }
    
    func mapData(item: CharacterDetailModel.Response.Item) -> ICellViewModel {
        switch item {
        case let .avatar(icon):
            AvatarViewModel(url: icon)
        case let .description(title, name, url, action):
            DescriptionViewModel(title: title, name: name, url: url, action: action)
        case let .episode(name, airDate, episode, url, action):
            EpisodeViewModel(name: name, episode: episode, airDate: airDate, url: url, action: action)
        }
    }
}
