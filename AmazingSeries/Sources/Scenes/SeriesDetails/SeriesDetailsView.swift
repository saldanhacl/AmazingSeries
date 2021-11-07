//
//  SeriesDetailsView.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

protocol SeriesDetailsViewProtocol {
    func showData(_ data: SeriesDetails.ViewModel)
}

final class SeriesDetailsView: CodedView {
    
    enum Section: Int, CaseIterable {
        case header
    }
    
    // MARK: View Elements
    
    private lazy var pageTableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.register(DetailHeaderTableViewCell.self, forCellReuseIdentifier: DetailHeaderTableViewCell.className)
        return view
    }()
    
    // MARK: Private properties
    
    private var viewModel: SeriesDetails.ViewModel?
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        addSubview(pageTableView)
    }

    override func setupConstraints() {
        constrainPageTableView()
    }
    
    private func constrainPageTableView() {
        pageTableView.fillSuperview()
    }
}

// MARK: UITableViewDataSource

extension SeriesDetailsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section(rawValue: section)
        switch section {
        case .header:
            return 1
        case .none:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCellFor(indexPath)
        return cell
    }
    
    // MARK: Private methods
    
    private func getCellFor(_ indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .header:
            let cell = pageTableView.dequeueReusableCell(with: DetailHeaderTableViewCell.self, for: indexPath)
            cell.setupData(title: viewModel.name, genres: viewModel.genres, imageURL: viewModel.posterURL)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

// MARK: SeriesDetailsViewProtocol

extension SeriesDetailsView: SeriesDetailsViewProtocol {
    func showData(_ data: SeriesDetails.ViewModel) {
        viewModel = data
        pageTableView.reloadData()
    }
}
