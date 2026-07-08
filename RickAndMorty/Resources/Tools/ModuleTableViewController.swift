//
//  ModuleTableViewController.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import UIKit

protocol IModuleTableView: AnyObject {
    func update(sections: [SectionViewModel])
}

class ModuleTableViewController: UIViewController {
    var sections = [SectionViewModel]()
    var tableView = UITableView()
    
    private var keyboardWillShowObserver: NSObjectProtocol?
    private var keyboardWillHideObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotificationServices()
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        notification.userInfo
            .flatMap { $0[UIResponder.keyboardFrameEndUserInfoKey] }
            .flatMap { $0 as? NSValue }
            .map(\.cgRectValue.height)
            .map { UIEdgeInsets(top: 0, left: 0, bottom: $0, right: 0) }
            .map { insets in
                tableView.contentInset = insets
                tableView.scrollIndicatorInsets = insets
            }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
    
    func cellViewModel(for indexPath: IndexPath) -> ICellViewModel? {
        guard indexPath.item < sections[indexPath.section].viewModels.count else { return nil }
        return sections[indexPath.section].viewModels[indexPath.item]
    }
    
    deinit {
        if let observer = keyboardWillShowObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        
        if let observer = keyboardWillHideObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}

private extension ModuleTableViewController {
    func setupNotificationServices() {
        keyboardWillShowObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main, using: keyboardWillShow)
        
        keyboardWillHideObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main, using: keyboardWillHide)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        
        tableView.registeringCellsInTable(
            
        )
        
        view.subviewsOnView(tableView)
        tableView.fullScreen()
    }
}

extension ModuleTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension ModuleTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < sections.count else { return 0 }
        return sections[section].viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            !sections.isEmpty,
            indexPath.section < sections.count,
            indexPath.row < sections[indexPath.section].viewModels.count
        else {
            return UITableViewCell()
        }
        
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: sections[indexPath.section].viewModels[indexPath.row].cellReuseID(),
                for: indexPath
            ) as? ITableViewCell else {
            return UITableViewCell()
        }
        let cellModel = sections[indexPath.section].viewModels[indexPath.row]
        
        cell.selectionStyle = .none
        cell.configure(viewModel: cellModel)
        
        return cell
    }
}
