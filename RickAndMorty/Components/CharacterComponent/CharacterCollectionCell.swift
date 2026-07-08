//
//  CharacterCollectionCell.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 08.07.2026.
//

import UIKit

final class CharacterCollectionCell: UICollectionViewCell {
    private let containerView = UIView()
    private let nameLabel = UILabel()
    private let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterCollectionCell: ICollectionViewCell {
    func configure(viewModel: ICellViewModel) {
        
    }
}

private extension CharacterCollectionCell {
    func setupView() {
        setupContainerView()
        setupLabel()
        setupIconImageView()
        
        subviewsOnView(containerView)
        containerView.subviewsOnView(nameLabel, iconImageView)
            
        setupConstraints()
    }
    
    func setupContainerView() {
        
    }
    
    func setupLabel() {
        
    }
    
    func setupIconImageView() {
        
    }
    
    func setupConstraints() {
        [containerView, nameLabel, iconImageView].forEach { $0.tAMIC() }
        
        NSLayoutConstraint.activate([
            
        ])
    }
}
