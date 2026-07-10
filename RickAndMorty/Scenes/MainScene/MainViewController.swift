//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import UIKit

protocol IMainView: IModuleCollectionView {
    
}

final class MainViewController: ModuleCollectionViewController {
    var interactor: IMainInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadData()
    }
}

extension MainViewController: IMainView {
    func update(sections: [SectionViewModel]) {
        self.sections = sections
        collectionView.reloadData()
    }
}
