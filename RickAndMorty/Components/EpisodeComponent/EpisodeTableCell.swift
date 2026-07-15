//
//  EpisodeTableCell.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import UIKit

final class EpisodeTableCell: UITableViewCell {
    
    private let containerView = UIView()
    
    private let nameLabel = UILabel()
    private let episodeLabel = UILabel()
    private let airDateLabel = UILabel()
    
    private weak var cellViewModel: EpisodeViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pressTo() {
        cellViewModel?.action(cellViewModel?.url ?? "")
    }
}

extension EpisodeTableCell: ITableViewCell {
    func configure(viewModel: any ICellViewModel) {
        guard let viewModel = viewModel as? EpisodeViewModel else { return }
        cellViewModel = viewModel
        
        nameLabel.text = viewModel.name
        episodeLabel.text = viewModel.episode
        airDateLabel.text = viewModel.airDate
    }
}

private extension EpisodeTableCell {
    func setupView() {
        setupContainerView()
        setupLabels()
        
        contentView.subviewsOnView(containerView)
        containerView.subviewsOnView(nameLabel, episodeLabel, airDateLabel)
        
        setupConstraints()
    }
    
    func setupContainerView() {
        containerView.backgroundColor = .darkGray
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pressTo)))
    }
    
    func setupLabels() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        
        episodeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        episodeLabel.textColor = .yellow
        episodeLabel.numberOfLines = 0
        episodeLabel.textAlignment = .left
        
        airDateLabel.font = UIFont.boldSystemFont(ofSize: 12)
        airDateLabel.textColor = .green
        airDateLabel.numberOfLines = 0
        airDateLabel.textAlignment = .right
    }
    
    func setupConstraints() {
        [containerView, nameLabel, episodeLabel, airDateLabel].forEach { $0.tAMIC() }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            
            episodeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            episodeLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            episodeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            airDateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            airDateLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8)
        ])
    }
}
