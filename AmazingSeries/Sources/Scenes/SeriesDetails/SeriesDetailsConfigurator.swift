//
//  SeriesDetailsConfigurator.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

struct SeriesDetailsParameters {
    let id: Int
}

protocol SeriesDetailsConfiguratorProtocol {
    func resolveViewController(parameters: SeriesDetailsParameters) -> UIViewController
}

final class SeriesDetailsConfigurator: SeriesDetailsConfiguratorProtocol {
    
    func resolveViewController(parameters: SeriesDetailsParameters) -> UIViewController {
        let getSeriesDetailsWoker = GetSeriesDetailsWorker()
        
        let router = SeriesDetailsRouter()
        let presenter = SeriesDetailsPresenter()
        let interactor = SeriesDetailsInteractor(seriesId: parameters.id, presenter: presenter, getSeriesDetailsWorker: getSeriesDetailsWoker)
        let viewController = SeriesDetailsViewController(interactor: interactor, router: router)
        
        presenter.viewController = viewController
        return viewController
    }
}

