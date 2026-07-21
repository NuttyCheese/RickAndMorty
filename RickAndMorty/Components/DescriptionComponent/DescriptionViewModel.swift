//
//  DescriptionViewModel.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import Foundation

final class DescriptionViewModel: ICellViewModel {
    let title: String
    let name: String
    let url: String
    let action: ((String) -> Void)?
    
    init(
        title: String,
        name: String,
        url: String,
        action: ((String) -> Void)?
    ) {
        self.title = title
        self.name = name
        self.url = url
        self.action = action
    }
    
    func cellReuseID() -> String {
        DescriptionTableCell.description()
    }
}
