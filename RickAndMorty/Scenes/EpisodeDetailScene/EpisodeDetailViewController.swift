//
//  EpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import UIKit

protocol IEpisodeDetailView: IModuleCollectionView { }

final class EpisodeDetailViewController: ModuleCollectionViewController {
    var interactor: IEpisodeDetailInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadData()
    }
}

extension EpisodeDetailViewController: IEpisodeDetailView {
    func update(sections: [SectionViewModel]) {
        self.sections = sections
        collectionView.reloadData()
    }
}
