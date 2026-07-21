//
//  CharacterDetailInteractor.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import Foundation

protocol ICharacterDetailInteractor {
    func loadData()
}

final class CharacterDetailInteractor {
    private let presenter: ICharacterDetailPresenter
    private let router: ICharacterDetailRouter
    private let worker: ICharacterDetailWorker
    private let sectionManager: ICharacterDetailSectionManager
    private let identifier: Int
    
    private var sections = [CharacterDetailModel.Response.CharacterDetailSection]()
    
    init(
        presenter: ICharacterDetailPresenter,
        router: ICharacterDetailRouter,
        worker: ICharacterDetailWorker,
        sectionManager: ICharacterDetailSectionManager,
        identifier: Int
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.sectionManager = sectionManager
        self.identifier = identifier
    }
}

extension CharacterDetailInteractor: ICharacterDetailInteractor {
    func loadData() {
        worker.fetchLoadData(identifier: identifier) { [weak self] character in
            guard let self else { return }
            
            let avatarSection = sectionManager.createAvatar(icon: character?.image ?? "")
            let nameSection = sectionManager.createDescriptions(
                title: "Имя",
                name: character?.name ?? "",
                url: "",
                action: nil
            )
            let statusSection = sectionManager.createDescriptions(
                title: "Статус",
                name: character?.status ?? "",
                url: "",
                action: nil
            )
            let speciesSection = sectionManager.createDescriptions(
                title: "Вид",
                name: character?.species ?? "",
                url: "",
                action: nil
            )
            let typeSection = sectionManager.createDescriptions(
                title: "Тип",
                name: character?.type ?? "",
                url: "",
                action: nil
            )
            let genderSection = sectionManager.createDescriptions(
                title: "Пол",
                name: character?.gender ?? "",
                url: "",
                action: nil
            )
            let originSection = sectionManager.createDescriptions(
                title: "Родной мира",
                name: character?.origin.name ?? "",
                url: character?.origin.url ?? "",
                action: { urlOrigin in
                    print("url origin - \(urlOrigin)")
                }
            )
            let locationSection = sectionManager.createDescriptions(
                title: "Текущее местоположение",
                name: character?.location.name ?? "",
                url: character?.location.url ?? "",
                action: { urlLocation in
                    print("url location - \(urlLocation)")
                }
            )
            
            worker.fetchLoadEpisode(identifier: identifier) { episodes in
                let episodeSection = self.sectionManager.createEpisodes(
                    episodes: episodes ?? []
                ) { urlEpisode in
                    print("url episode - \(urlEpisode)")
                }
    
                self.sections.append(avatarSection)
                self.sections.append(nameSection)
                self.sections.append(statusSection)
                self.sections.append(speciesSection)
                self.sections.append(typeSection)
                self.sections.append(genderSection)
                self.sections.append(originSection)
                self.sections.append(locationSection)
                self.sections.append(episodeSection)
                
                self.presenter.publish(data: CharacterDetailModel.Response(data: self.sections))
            }
            
        }
    }
}

private extension CharacterDetailInteractor {
    
}
