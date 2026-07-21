//
//  MainPresenter.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

protocol IMainPresenter {
    func publish(data: MainModel.Response)
}

final class MainPresenter {
    weak var viewController: IMainView?
}

extension MainPresenter: IMainPresenter {
    func publish(data: MainModel.Response) {
        let sectionViewModel = data.data.map(mapData)
        viewController?.update(sections: sectionViewModel)
    }
}

private extension MainPresenter {
    func mapData(_ section: MainModel.Response.MainSection) -> SectionViewModel {
        SectionViewModel(title: section.section.text, viewModels: section.items.map(mapData))
    }
    
    func mapData(item: MainModel.Response.Item) -> ICellViewModel {
        switch item {
        case let .character(iconName, name, id, action):
            CharacterViewModel(iconName: iconName, name: name, id: id, action: action)
        }
    }
}
