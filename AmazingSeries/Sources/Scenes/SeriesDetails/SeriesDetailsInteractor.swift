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
    
    
    // MARK: Initialization
    
    init(presenter: SeriesDetailsPresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: ListSeriesBusinessLogic

extension SeriesDetailsInteractor: SeriesDetailsBusinessLogic {
    func onViewDidLoad() {}
}
