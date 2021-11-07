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
    func didSelectSeries(id: Int)
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
    
    private lazy var seriesCollectionView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(SeriesTableViewCell.self, forCellReuseIdentifier: SeriesTableViewCell.className)
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        addSubview(searchView)
        addSubview(seriesCollectionView)
    }
    
    override func setupConstraints() {
        constrainSearchView()
        constrainTableView()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .white
    }
    
    private func constrainSearchView() {
        searchView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 12.0
        )
    }
    
    private func constrainTableView() {
        seriesCollectionView.anchor(
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
        
        cell.setupData(title: viewModel.name, posterImageURL: viewModel.posterURL)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seriesId = filteredListSeriesViewModels[indexPath.row].id
        delegate?.didSelectSeries(id: seriesId)
    }
}

// MARK: UISearchBarDelegate

extension ListSeriesView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredListSeriesViewModels = searchText.isEmpty ? listSeriesViewModels : listSeriesViewModels.filter { (item: ListSeries.ViewModel) -> Bool in
            item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        seriesCollectionView.reloadData()
    }
}

// MARK: ListSeriesViewProtocol

extension ListSeriesView: ListSeriesViewProtocol {
    func showSeriesList(_ data: [ListSeries.ViewModel]) {
        listSeriesViewModels = data
        seriesCollectionView.reloadData()
    }
    
    func appendSeriesData(_ data: [ListSeries.ViewModel]) {
        listSeriesViewModels.append(contentsOf: data)
        seriesCollectionView.reloadData()
    }
}
