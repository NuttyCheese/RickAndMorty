//
//  ModuleCollectionViewController.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import UIKit

protocol IModuleCollectionView: AnyObject {
    func update(sections: [SectionViewModel])
}

class ModuleCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var sections = [SectionViewModel]()
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 4, left: 8, bottom: 1, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func cellViewModel(for indexPath: IndexPath) -> ICellViewModel? {
        guard indexPath.item < sections[indexPath.section].viewModels.count else { return nil }
        return sections[indexPath.section].viewModels[indexPath.item]
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            collectionView.scrollIndicatorInsets = collectionView.contentInset
        }
    }

    @objc private func keyboardWillHide(notification _: Notification) {
        collectionView.contentInset = .zero
        collectionView.scrollIndicatorInsets = .zero
    }
}

extension ModuleCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !sections.isEmpty, section < sections.count else { return 4 }
        return sections[section].viewModels.count
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !sections.isEmpty, indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].viewModels.count
        else {
            return UICollectionViewCell()
        }

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: sections[indexPath.section].viewModels[indexPath.row].cellReuseID(),
            for: indexPath
        ) as? ICollectionViewCell else { return UICollectionViewCell() }

        cell.backgroundColor = .clear
        cell.configure(viewModel: sections[indexPath.section].viewModels[indexPath.row])

        return cell
    }
}

private extension ModuleCollectionViewController {
    func setupView() {
        setupCollectionView()
        setupNotificationServices()
    }
    
    func setupNotificationServices() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(
                keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(
                keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
        
        collectionView.registeringCellsInCollection(
            CharacterCollectionCell.self
        )
        view.subviewsOnView(collectionView)
        collectionView.fullScreen()
    }
}
