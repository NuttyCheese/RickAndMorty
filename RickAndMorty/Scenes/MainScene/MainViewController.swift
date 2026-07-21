//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import UIKit

protocol IMainView: IModuleCollectionView {
    
}

final class MainViewController: ModuleCollectionViewController {
    var interactor: IMainInteractor!
    private var isLoadingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadData()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        // Добавляем footer для индикатора загрузки (опционально)
        collectionView.register(UICollectionReusableView.self,
                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                               withReuseIdentifier: "LoadingFooter")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Когда дошли до 80% контента - загружаем следующую страницу
        if offsetY > contentHeight - height * 1.2 {
            guard !isLoadingMore else { return }
            isLoadingMore = true
            interactor.loadNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        let screenBounds = UIScreen.main.bounds
            
        let width = screenBounds.width / 2.16
        let height = screenBounds.height / 4
            
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       referenceSizeForFooterInSection section: Int) -> CGSize {
        // Показываем индикатор загрузки внизу
        if isLoadingMore {
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                       viewForSupplementaryElementOfKind kind: String,
                       at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "LoadingFooter",
                for: indexPath
            )
            
            // Добавляем индикатор загрузки
            if let spinner = footer.viewWithTag(999) as? UIActivityIndicatorView {
                spinner.startAnimating()
            } else {
                let spinner = UIActivityIndicatorView(style: .medium)
                spinner.tag = 999
                spinner.color = .white
                spinner.startAnimating()
                spinner.center = footer.center
                footer.addSubview(spinner)
            }
            
            return footer
        }
        return UICollectionReusableView()
    }
}

extension MainViewController: IMainView {
    func update(sections: [SectionViewModel]) {
        self.sections = sections
        collectionView.reloadData()
        isLoadingMore = false
    }
}
