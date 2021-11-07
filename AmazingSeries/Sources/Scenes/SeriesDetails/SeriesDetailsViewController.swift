//
//  SeriesDetailsViewController.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

protocol SeriesDetailsDisplayLogic: AnyObject {
    func displayData(_ data: SeriesDetails.ViewModel)
}

final class SeriesDetailsViewController: UIViewController {
    
    // MARK: Dependencies
    
    private let interactor: SeriesDetailsBusinessLogic
    private let router: SeriesDetailsRoutingLogic
    
    // MARK: - Private properties
    
    private var contentView: SeriesDetailsViewProtocol?
    
    // MARK: Initialization
    
    init(interactor: SeriesDetailsBusinessLogic, router: SeriesDetailsRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        view = SeriesDetailsView()
        view.backgroundColor = .blue
        contentView = view as? SeriesDetailsViewProtocol
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: SeriesDetailsDisplayLogic

extension SeriesDetailsViewController: SeriesDetailsDisplayLogic {
    func displayData(_ data: SeriesDetails.ViewModel) {
        contentView?.showData(data)
    }
}
