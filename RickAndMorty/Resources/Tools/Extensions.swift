//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import UIKit

extension UIView {
    /// Устанавливает свойство `isUserInteractionEnabled` в `true`.
    func enable() {
        isUserInteractionEnabled = true
    }

    /// Устанавливает свойство `isUserInteractionEnabled` в `false`.
    func disable() {
        isUserInteractionEnabled = false
    }

    /// Устанавливает свойство `translatesAutoresizingMaskIntoConstraints` в `false`.
    func tAMIC() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    /// Добавляет несколько подвью на текущее представление.
    ///
    /// - Parameter subviews: Массив подвью для добавления.
    func subviewsOnView(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    private var superView: UIView { superview! }
    
    func fullScreen(_ view: UIView? = nil) {
        tAMIC()

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view?.topAnchor ?? superView.topAnchor),
            leftAnchor.constraint(equalTo: view?.leftAnchor ?? superView.leftAnchor),
            rightAnchor.constraint(equalTo: view?.rightAnchor ?? superView.rightAnchor),
            bottomAnchor.constraint(equalTo: view?.bottomAnchor ?? superView.bottomAnchor),
        ])
    }
}

extension UITableView {
    /// Регистрирует множество различных ячеек в таблице.
    ///
    /// Каждая переданная ячейка регистрируется с использованием ее типа в качестве идентификатора.
    ///
    /// - Parameter cells: Типы ячеек для регистрации.
    func registeringCellsInTable(_ cells: UITableViewCell.Type...) {
        for cell in cells {
            register(cell, forCellReuseIdentifier: cell.description())
        }
    }
}

extension UICollectionView {
    /// Регистрирует множество различных ячеек в коллекции.
    ///
    /// Каждая переданная ячейка регистрируется с использованием ее типа в качестве идентификатора.
    ///
    /// - Parameter cells: Типы ячеек для регистрации.
    func registeringCellsInCollection(_ cells: UICollectionViewCell.Type...) {
        for cell in cells {
            register(cell, forCellWithReuseIdentifier: cell.description())
        }
    }
}
