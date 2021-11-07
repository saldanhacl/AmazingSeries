//
//  ListSeriesConfigurator.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

protocol ListSeriesConfiguratorProtocol {
    func resolveViewController() -> UIViewController
}

final class ListSeriesConfigurator: ListSeriesConfiguratorProtocol {

    func resolveViewController() -> UIViewController {
        let getSeriesWorker = GetSeriesWorker()
        
        let seriesDetailsConfigurator = SeriesDetailsConfigurator()
        let router = ListSeriesRouter(sceneFactory: seriesDetailsConfigurator)
        let presenter = ListSeriesPresenter()
        let interactor = ListSeriesInteractor(presenter: presenter, getSeriesWorker: getSeriesWorker)
        let viewController = ListSeriesViewController(interactor: interactor, router: router)
        
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
