//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import UIKit

protocol ICharacterDetailView: IModuleTableView { }

final class CharacterDetailViewController: ModuleTableViewController {
    var interactor: ICharacterDetailInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < sections.count else { return nil }
        
        // Показываем тайтл только для секции с эпизодами
        if sections[section].title == CharacterDetailTitleSection.episodes.rawValue {
            return sections[section].title
        }
        
        // Для всех остальных секций возвращаем nil (заголовок не показывается)
        return nil
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section < sections.count else { return 0 }
        
        // Для секции с эпизодами устанавливаем высоту
        if sections[section].title == CharacterDetailTitleSection.episodes.rawValue {
            return 44
        }
        
        // Для остальных секций высота = 0 (заголовок не виден)
        return 0
    }
}

extension CharacterDetailViewController: ICharacterDetailView {
    func update(sections: [SectionViewModel]) {
        self.sections = sections
        tableView.reloadData()
    }
}
