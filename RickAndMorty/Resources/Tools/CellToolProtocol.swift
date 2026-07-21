//
//  CellToolProtocol.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import UIKit

protocol ITableViewCell where Self: UITableViewCell {
    func configure(viewModel: ICellViewModel)
}

protocol ICollectionViewCell where Self: UICollectionViewCell {
    func configure(viewModel: ICellViewModel)
}
