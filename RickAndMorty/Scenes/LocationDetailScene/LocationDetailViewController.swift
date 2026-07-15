//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 15.07.2026.
//

import UIKit

protocol ILocationDetailView: IModuleCollectionView {
    
}

final class LocationDetailViewController: ModuleCollectionViewController {
    var interactor: ILocationDetailInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadData()
    }
}

extension LocationDetailViewController: ILocationDetailView {
    func update(sections: [SectionViewModel]) {
        self.sections = sections
        collectionView.reloadData()
    }
}
