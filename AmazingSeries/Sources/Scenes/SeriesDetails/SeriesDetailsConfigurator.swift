//
//  SeriesDetailsConfigurator.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

final class SeriesDetailsConfigurator: SceneFactory {
    
    func resolveViewController() -> UIViewController {
        let router = SeriesDetailsRouter()
        let presenter = SeriesDetailsPresenter()
        let interactor = SeriesDetailsInteractor(presenter: presenter)
        let viewController = SeriesDetailsViewController(interactor: interactor, router: router)
        
        presenter.viewController = viewController
        return viewController
    }
}

