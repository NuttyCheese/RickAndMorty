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
    private weak var cellViewModel: CharacterViewModel?
    
    private var currentLoadTask: Cancellable?
        
    override func prepareForReuse() {
        super.prepareForReuse()
        currentLoadTask?.cancel() // Отменяем предыдущую загрузку
        currentLoadTask = nil
        iconImageView.image = nil
        nameLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pressTo() {
        cellViewModel?.action(cellViewModel?.id ?? 0)
    }
}

extension CharacterCollectionCell: ICollectionViewCell {
    func configure(viewModel: ICellViewModel) {
        guard let viewModel = viewModel as? CharacterViewModel else { return }
        cellViewModel = viewModel
        
        nameLabel.text = viewModel.name
        
        currentLoadTask = ImageCacheManager.shared.loadImage(
                    from: viewModel.iconName,
                    into: iconImageView,
                    placeholder: Images.imgNotPhoto.image
                )
    }
}

private extension CharacterCollectionCell {
    func setupView() {
        setupContainerView()
        setupLabel()
        setupIconImageView()
        
        contentView.subviewsOnView(containerView)
        containerView.subviewsOnView(nameLabel, iconImageView)
            
        setupConstraints()
    }
    
    func setupContainerView() {
        containerView.backgroundColor = .darkGray // Или .systemGray6
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pressTo)))
    }
    
    func setupLabel() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
    }
    
    func setupIconImageView() {
        iconImageView.contentMode = .scaleAspectFill // .scaleAspectFit был
        iconImageView.clipsToBounds = true // Важно!
        iconImageView.layer.cornerRadius = 8
    }
    
    func setupConstraints() {
        [containerView, nameLabel, iconImageView].forEach { $0.tAMIC() }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            iconImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 4),
            iconImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -4),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4),
            nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 4),
            nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
        ])
    }
}

