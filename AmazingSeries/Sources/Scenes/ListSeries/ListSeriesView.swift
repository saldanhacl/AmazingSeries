//
//  ListSeriesView.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

protocol ListSeriesViewProtocol {
    var delegate: ListSeriesViewDelegate? { get set }
    
    func showSeriesList(_ data: [ListSeries.ViewModel])
    func appendSeriesData(_ data: [ListSeries.ViewModel])
}

protocol ListSeriesViewDelegate: AnyObject {
    func fetchMoredData()
}

final class ListSeriesView: CodedView {
    // MARK: Dependencies
    
    weak var delegate: ListSeriesViewDelegate?
    
    // MARK: Private properties
    
    private var listSeriesViewModels: [ListSeries.ViewModel] = [] {
        didSet {
            filteredListSeriesViewModels = listSeriesViewModels
        }
    }
    
    private var filteredListSeriesViewModels: [ListSeries.ViewModel] = []

    // MARK: View Elements
    
    private lazy var searchView: UISearchBar = {
        let view = UISearchBar()
        view.searchBarStyle = .minimal
        view.delegate = self
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(SeriesTableViewCell.self, forCellReuseIdentifier: SeriesTableViewCell.className)
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        addSubview(searchView)
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        constrainSearchView()
        constrainTableView()
    }
    
    private func constrainSearchView() {
        searchView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
    }
    
    private func constrainTableView() {
        tableView.anchor(
            top: searchView.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
        )
    }
}

// MARK: UITableViewDataSource

extension ListSeriesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredListSeriesViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SeriesTableViewCell.self, for: indexPath)
        let viewModel = filteredListSeriesViewModels[indexPath.row]
        
        cell.setupData(title: viewModel.name)
        return cell
    }
}

// MARK: UITableViewDelegate

extension ListSeriesView: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if maximumOffset - currentOffset <= 2 {
            delegate?.fetchMoredData()
        }
    }
}

// MARK: UISearchBarDelegate

extension ListSeriesView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredListSeriesViewModels = searchText.isEmpty ? listSeriesViewModels : listSeriesViewModels.filter { (item: ListSeries.ViewModel) -> Bool in
            item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
}

// MARK: ListSeriesViewProtocol

extension ListSeriesView: ListSeriesViewProtocol {
    func showSeriesList(_ data: [ListSeries.ViewModel]) {
        listSeriesViewModels = data
        tableView.reloadData()
    }
    
    func appendSeriesData(_ data: [ListSeries.ViewModel]) {
        listSeriesViewModels.append(contentsOf: data)
        tableView.reloadData()
    }
}
