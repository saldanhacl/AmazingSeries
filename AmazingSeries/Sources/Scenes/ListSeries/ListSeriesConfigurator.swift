//
//  ListSeriesConfigurator.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

final class ListSeriesConfigurator: SceneFactory {

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
