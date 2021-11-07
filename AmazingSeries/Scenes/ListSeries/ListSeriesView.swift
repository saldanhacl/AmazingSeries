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

final class ListSeriesView: UIView {
    
    // MARK: Dependencies
    
    weak var delegate: ListSeriesViewDelegate?
    
}

// MARK: View Code

extension ListSeriesView: ViewCode {
    func buildHierarchy() {}
    func setupConstraints() {}
}

// MARK: ListSeriesViewProtocol

extension ListSeriesView: ListSeriesViewProtocol {
    
}
