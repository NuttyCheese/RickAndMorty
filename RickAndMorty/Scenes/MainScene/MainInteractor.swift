//
//  MainInteractor.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

protocol IMainInteractor {
    func loadData()
    func loadNextPage() // Добавляем метод для загрузки следующей страницы
}

final class MainInteractor {
    private let router: IMainRouter
    private let presenter: IMainPresenter
    private let worker: IMainWorker
    private let sectionManager: IMainSectionManager
    
    private var sections = [MainModel.Response.MainSection]()
    private var currentPage = 1
    private var isLoading = false
    private var hasMoreData = true
    
    init(
        router: IMainRouter,
        presenter: IMainPresenter,
        worker: IMainWorker,
        sectionManager: IMainSectionManager
    ) {
        self.router = router
        self.presenter = presenter
        self.worker = worker
        self.sectionManager = sectionManager
    }
}

extension MainInteractor: IMainInteractor {
    func loadData() {
        currentPage = 1
        hasMoreData = true
        sections.removeAll()
        loadPage()
    }
    
    func loadNextPage() {
        guard !isLoading && hasMoreData else { return }
        currentPage += 1
        loadPage()
    }
}

private extension MainInteractor {
    func loadPage() {
        isLoading = true
        
        worker.loadCharacters(page: currentPage) { [weak self] characters in
            guard
                let self,
                let results = characters?.results,
                let info = characters?.info
            else { return }
            
            self.isLoading = false
            
            // Проверяем, есть ли еще данные
            if results.isEmpty {
                self.hasMoreData = false
                return
            }
            
            // Проверяем, что страница не пустая
            guard let characters = characters,
                  !results.isEmpty else {
                self.hasMoreData = false
                return
            }
            
            // Обновляем флаг hasMoreData на основе info.next
            self.hasMoreData = info.next != nil
            
            
            // Создаем секцию с персонажами
            let charSection = sectionManager.createCharactersSection(
                characters: characters
            ) { [weak self] id in
                guard let self else { return }
                self.router.transitionById(from: id)
            }
            
            // Добавляем секцию
            self.sections.append(charSection)
            
            // Отправляем данные презентеру
            self.presenter.publish(data: MainModel.Response(data: self.sections))
        }
    }
}
