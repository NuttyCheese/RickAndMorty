//
//  EpisodeTableCell.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import UIKit

final class EpisodeTableCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EpisodeTableCell: ITableViewCell {
    func configure(viewModel: any ICellViewModel) {
        guard let viewModel = viewModel as? EpisodeViewModel else { return }
    }
}
