//
//  EpisodeDetailsViewController.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 08/11/21.
//

import UIKit

protocol EpisodeDetailsDisplayLogic: AnyObject {
    func displayViewData(_ data: EpisodeDetails.ViewModel)
}

class EpisodeDetailsViewController: UIViewController {
    
    // MARK: Dependencies
    
    private let interactor: EpisodeDetailsBusinessLogic
    
    // MARK: - Private properties
    
    private var contentView: EpisodeDetailsViewProtocol?
    
    // MARK: Initialization
    
    init(interactor: EpisodeDetailsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    
    override func loadView() {
        super.loadView()
        
        view = EpisodeDetailsView()
        contentView = view as? EpisodeDetailsViewProtocol
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.onViewDidLoad()
    }
}

// MARK: EpisodeDetailsDisplayLogic

extension EpisodeDetailsViewController: EpisodeDetailsDisplayLogic {
    func displayViewData(_ data: EpisodeDetails.ViewModel) {
        contentView?.showViewData(data)
    }
}
