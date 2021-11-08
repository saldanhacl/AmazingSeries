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
    func didChangeSearchQuery(_ query: String)
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
    
    private let containterView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Home"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return view
    }()
    
    private lazy var searchView: UISearchBar = {
        let view = UISearchBar()
        view.searchBarStyle = .minimal
        view.barStyle = .black
        view.delegate = self
        return view
    }()
    
    private lazy var seriesTableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .clear
        view.register(SeriesTableViewCell.self, forCellReuseIdentifier: SeriesTableViewCell.className)
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        addSubview(containterView)
        containterView.addSubview(titleLabel)
        containterView.addSubview(searchView)
        containterView.addSubview(seriesTableView)
    }
    
    override func setupConstraints() {
        constrainContainerView()
        constrainTitleLabel()
        constrainSearchView()
        constrainTableView()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .black
    }
    
    private func constrainContainerView() {
        let spacing = 16.0
        containterView.fillSuperview(paddingTop: spacing, paddingLeading: spacing, paddingTrailing: spacing)
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: containterView.topAnchor,
            leading: containterView.leadingAnchor,
            trailing: containterView.trailingAnchor,
            paddingTop: 24.0
        )
    }
    
    private func constrainSearchView() {
        searchView.anchor(
            top: titleLabel.bottomAnchor,
            leading: containterView.leadingAnchor,
            trailing: containterView.trailingAnchor,
            paddingTop: 12.0
        )
    }
    
    private func constrainTableView() {
        seriesTableView.anchor(
            top: searchView.bottomAnchor,
            leading: containterView.leadingAnchor,
            bottom: containterView.bottomAnchor,
            trailing: containterView.trailingAnchor
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
        
        cell.setupData(
            title: viewModel.title,
            genres: viewModel.genres,
            rating: viewModel.rating,
            posterImageURL: viewModel.posterURL
        )
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
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchSeries), object: nil)
        perform(#selector(searchSeries), with: nil, afterDelay: 0.5)
    }
    
    @objc private func searchSeries() {
        guard let searchText = searchView.text else { return }
        delegate?.didChangeSearchQuery(searchText)
    }
}

// MARK: ListSeriesViewProtocol

extension ListSeriesView: ListSeriesViewProtocol {
    func showSeriesList(_ data: [ListSeries.ViewModel]) {
        listSeriesViewModels = data
        seriesTableView.reloadData()
    }
    
    func appendSeriesData(_ data: [ListSeries.ViewModel]) {
        listSeriesViewModels.append(contentsOf: data)
        seriesTableView.reloadData()
    }
}
