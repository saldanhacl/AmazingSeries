//
//  ListSeriesView.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit


protocol ListSeriesViewProtocol {
    
}

protocol ListSeriesViewDelegate: AnyObject {
    
}

final class ListSeriesView: CodedView {
    
    // MARK: Dependencies
    
    weak var delegate: ListSeriesViewDelegate?
    
    // MARK: View Elements
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
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

// MARK: ListSeriesViewProtocol

extension ListSeriesView: ListSeriesViewProtocol {
    
}
