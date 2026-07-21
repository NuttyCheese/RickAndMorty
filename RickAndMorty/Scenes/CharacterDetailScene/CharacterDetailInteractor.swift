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
                action: { [weak self] urlOrigin in
                    guard let self, let url = URL(string: urlOrigin) else { return }
                    let id = Int(url.lastPathComponent) ?? 0
                    router.transitionByLocation(from: id)
                }
            )
            let locationSection = sectionManager.createDescriptions(
                title: "Текущее местоположение",
                name: character?.location.name ?? "",
                url: character?.location.url ?? "",
                action: { [weak self] urlLocation in
                    guard let self, let url = URL(string: urlLocation) else { return }
                    let id = Int(url.lastPathComponent) ?? 0
                    router.transitionByLocation(from: id)
                }
            )
            
            worker.fetchLoadEpisode(identifier: identifier) { episodes in
                let episodeSection = self.sectionManager.createEpisodes(
                    episodes: episodes ?? []
                ) { [weak self] urlEpisode in
                    guard let self, let url = URL(string: urlEpisode) else { return }
                    let id = Int(url.lastPathComponent) ?? 0
                    router.transitionByEpisode(from: id)
                }
    
                self.sections.append(avatarSection)
                if let name = character?.name, !name.isEmpty {
                    self.sections.append(nameSection)
                }
                if let status = character?.status, !status.isEmpty {
                    self.sections.append(statusSection)
                }
                if let species = character?.species, !species.isEmpty {
                    self.sections.append(speciesSection)
                }
                if let type = character?.type, !type.isEmpty {
                    self.sections.append(typeSection)
                }
                if let gender = character?.gender, !gender.isEmpty {
                    self.sections.append(genderSection)
                }
                if let origin = character?.origin, !origin.name.isEmpty {
                    self.sections.append(originSection)
                }
                if let location = character?.location, !location.name.isEmpty {
                    self.sections.append(locationSection)
                }
                self.sections.append(episodeSection)
                
                self.presenter.publish(data: CharacterDetailModel.Response(data: self.sections))
            }
            
        }
    }
}

private extension CharacterDetailInteractor {
    
}
