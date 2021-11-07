//
//  ListSeriesView.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit


protocol ListSeriesViewProtocol {
    func showSeriesList(_ data: [ListSeries.ViewModel])
}

protocol ListSeriesViewDelegate: AnyObject {
    
}

final class ListSeriesView: CodedView {
    // MARK: Dependencies
    
    weak var delegate: ListSeriesViewDelegate?
    
    // MARK: Private properties
    
    private var listSeriesViewModels: [ListSeries.ViewModel] = []
    
    // MARK: View Elements
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.register(SeriesTableViewCell.self, forCellReuseIdentifier: SeriesTableViewCell.className)
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        constrainTableView()
    }
    
    private func constrainTableView() {
        tableView.fillSuperview()
    }
}

// MARK: UITableViewDataSource

extension ListSeriesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listSeriesViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SeriesTableViewCell.self, for: indexPath)
        let viewModel = listSeriesViewModels[indexPath.row]
        
        cell.setupData(title: viewModel.name)
        return cell
    }
}

// MARK: ListSeriesViewProtocol

extension ListSeriesView: ListSeriesViewProtocol {
    func showSeriesList(_ data: [ListSeries.ViewModel]) {
        listSeriesViewModels = data
        tableView.reloadData()
    }
}
