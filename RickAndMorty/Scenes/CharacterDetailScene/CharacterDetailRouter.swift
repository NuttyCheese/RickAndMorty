//
//  CharacterDetailRouter.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import UIKit

protocol ICharacterDetailRouter {
    func transitionByLocation(from id: Int)
    func transitionByEpisode(from id: Int)
}

final class CharacterDetailRouter {
    weak var transitionView: UIViewController?
}

extension CharacterDetailRouter: ICharacterDetailRouter {
    func transitionByLocation(from id: Int) {
        let vc = LocationDetailModule.build(identifier: id)
        
        vc.modalPresentationStyle = .formSheet
        vc.modalTransitionStyle = .coverVertical
        
        transitionView?.present(vc, animated: true, completion: nil)
    }
    
    func transitionByEpisode(from id: Int) {
        let vc = EpisodeDetailModule.build(identifier: id)
        
        vc.modalPresentationStyle = .formSheet
        vc.modalTransitionStyle = .coverVertical
        
        transitionView?.present(vc, animated: true, completion: nil)
    }
}
