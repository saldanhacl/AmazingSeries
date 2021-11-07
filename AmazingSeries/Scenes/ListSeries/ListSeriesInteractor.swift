//
//  ListSeriesInteractor.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

protocol ListSeriesBusinessLogic {
    
}

final class ListSeriesInteractor {
    
    // MARK: Dependencies
    
    private let presenter: ListSeriesPresentationLogic
    
    // MARK: Initialization
    
    init(presenter: ListSeriesPresentationLogic) {
        self.presenter = presenter
    }
    
}

// MARK: ListSeriesBusinessLogic

extension ListSeriesInteractor: ListSeriesBusinessLogic {
    
}
