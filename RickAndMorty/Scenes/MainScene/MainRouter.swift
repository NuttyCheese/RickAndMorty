//
//  MainRouter.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import UIKit

protocol IMainRouter {
    func transitionById(from id: Int)
}

final class MainRouter {
    weak var transitionHandler: UIViewController?
}

extension MainRouter: IMainRouter {
    func transitionById(from id: Int) {
        let vc = CharacterDetailModule.build(id: id)
        if let navVC = transitionHandler?.navigationController {
            navVC.pushViewController(vc, animated: true)
        }
    }
}
