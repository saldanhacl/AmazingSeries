//
//  SeriesDetailsViewController.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

protocol SeriesDetailsDisplayLogic: AnyObject {
    func displayData(_ data: SeriesDetails.ViewModel)
    func displaySeasonsData(_ data: [Episodes.ViewModel.Season])
    func displayErrorState()
}

final class SeriesDetailsViewController: UIViewController {
    
    // MARK: Dependencies
    
    private let interactor: SeriesDetailsBusinessLogic
    private let router: SeriesDetailsRoutingLogic
    
    // MARK: - Private properties
    
    private var contentView: SeriesDetailsViewProtocol?
    
    // MARK: View Elements
    
    private lazy var backButton: UIButton = {
        let view = UIButton()
        view.tintColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16.0
        view.frame = CGRect(x: .zero, y: .zero, width: 32, height: 32)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.setImage(UIImage(named: "back_arrow"), for: .normal)

        view.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return view
    }()
   
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
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = SeriesDetailsView()
        contentView = view as? SeriesDetailsViewProtocol
        contentView?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    // MARK: Actions
    
    @objc private func backButtonTapped(sender: UIButton) {
        router.goBack()
    }
}

// MARK: SeriesDetailsDisplayLogic

extension SeriesDetailsViewController: SeriesDetailsDisplayLogic {
    func displayData(_ data: SeriesDetails.ViewModel) {
        contentView?.showData(data)
    }
    
    func displaySeasonsData(_ data: [Episodes.ViewModel.Season]) {
        contentView?.showSeasonsData(data)
    }
    
    func displayErrorState() {
        contentView?.showErrorView()
    }
}

// MARK: SeriesDetailsViewDelegate

extension SeriesDetailsViewController: SeriesDetailsViewDelegate {
    func didSelectEpisode(_ data: Episodes.ViewModel.Episode) {
        router.goToEpisode(data)
    }
    
    func reloadData() {
        interactor.onViewDidLoad()
    }
}
