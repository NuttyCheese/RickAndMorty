//
//  DescriptionTableCell.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import UIKit

final class DescriptionTableCell: UITableViewCell {
    private let containerView = UIView()
    private let customLabel = UILabel()
    private var tapGesture: UITapGestureRecognizer?
    
    private weak var cellViewModel: DescriptionViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        customLabel.text = nil
        customLabel.attributedText = nil
        customLabel.isUserInteractionEnabled = false
        if let tap = tapGesture {
            customLabel.removeGestureRecognizer(tap)
            tapGesture = nil
        }
    }
}

extension DescriptionTableCell: ITableViewCell {
    func configure(viewModel: any ICellViewModel) {
        guard let viewModel = viewModel as? DescriptionViewModel else { return }
        cellViewModel = viewModel
        
        let hasUrl = !viewModel.url.isEmpty && viewModel.url != ""
        let fullText = "\(viewModel.title) \n\(viewModel.name)"
        
        if hasUrl {
            let attributedString = NSMutableAttributedString(string: fullText)
            let range = NSRange(location: 0, length: fullText.count)
            
            // Подчеркивание
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            attributedString.addAttribute(.underlineColor, value: UIColor.systemYellow, range: range)
            attributedString.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: range)
            
            customLabel.attributedText = attributedString
            
            customLabel.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
            customLabel.addGestureRecognizer(tap)
            tapGesture = tap
            
        } else {
            customLabel.text = fullText
            customLabel.isUserInteractionEnabled = false
            customLabel.textColor = .white
        }
    }
    
    @objc private func labelTapped() {
        guard let url = cellViewModel?.url, !url.isEmpty else { return }
        cellViewModel?.action?(url)
    }
}

private extension DescriptionTableCell {
    func setupView() {
        setupContainerView()
        setupLabel()
        
        contentView.subviewsOnView(containerView)
        containerView.subviewsOnView(customLabel)
        
        setupConstraints()
    }
    
    func setupContainerView() {
        containerView.backgroundColor = .darkGray
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
    }
    
    func setupLabel() {
        customLabel.font = UIFont.boldSystemFont(ofSize: 12)
        customLabel.textColor = .white
        customLabel.numberOfLines = 0
        customLabel.textAlignment = .left
    }
    
    func setupConstraints() {
        [containerView, customLabel].forEach { $0.tAMIC() }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            customLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            customLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            customLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),
            customLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
}
