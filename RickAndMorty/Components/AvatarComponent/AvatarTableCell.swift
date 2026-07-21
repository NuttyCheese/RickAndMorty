//
//  AvatarTableCell.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import UIKit

final class AvatarTableCell: UITableViewCell {
    
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private var currentLoadTask: Cancellable?
        
    override func prepareForReuse() {
        super.prepareForReuse()
        currentLoadTask?.cancel() // Отменяем предыдущую загрузку
        currentLoadTask = nil
        iconImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AvatarTableCell: ITableViewCell {
    func configure(viewModel: any ICellViewModel) {
        guard let viewModel = viewModel as? AvatarViewModel else { return }
        
        currentLoadTask = ImageCacheManager.shared.loadImage(
            from: viewModel.url,
            into: iconImageView,
            placeholder: Images.imgNotPhoto.image
        )
    }
}

private extension AvatarTableCell {
    func setupView() {
        setupContainerView()
        setupIconImageView()
        
        contentView.subviewsOnView(containerView)
        containerView.subviewsOnView(iconImageView)
            
        setupConstraints()
    }
    
    func setupContainerView() {
        containerView.backgroundColor = .darkGray // Или .systemGray6
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
    }
    
    
    func setupIconImageView() {
        iconImageView.contentMode = .scaleAspectFill // .scaleAspectFit был
        iconImageView.clipsToBounds = true // Важно!
        iconImageView.layer.cornerRadius = 8
    }
    
    func setupConstraints() {
        [containerView, iconImageView].forEach { $0.tAMIC() }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            iconImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 4),
            iconImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -4),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
        ])
    }
}

