//
//  SeriesDetailsInteractor.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

protocol SeriesDetailsBusinessLogic {
    func onViewDidLoad()
}

final class SeriesDetailsInteractor {
    
    // MARK: Dependencies
    
    private let presenter: SeriesDetailsPresentationLogic
    private let seriesId: Int
    
    
    // MARK: Initialization
    
    init(presenter: SeriesDetailsPresentationLogic, seriesId: Int) {
        self.presenter = presenter
        self.seriesId = seriesId
    }
}

// MARK: ListSeriesBusinessLogic

extension SeriesDetailsInteractor: SeriesDetailsBusinessLogic {
    func onViewDidLoad() {
        
    }
    
    // MARK: Private methods
    
    private func loadSeriesDetails() {
        
    }
}
