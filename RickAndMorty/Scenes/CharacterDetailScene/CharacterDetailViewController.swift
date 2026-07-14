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
}

extension CharacterDetailViewController: ICharacterDetailView {
    func update(sections: [SectionViewModel]) {
        self.sections = sections
        tableView.reloadData()
    }
}
