//
//  ListSeriesViewController.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

protocol ListSeriesDisplayLogic: AnyObject {
    func displaySeriesList(_ data: [ListSeries.ViewModel])
    func displayErrorState()
}

final class ListSeriesViewController: UIViewController {
    
    // MARK: Dependencies
    
    private let interactor: ListSeriesBusinessLogic
    private let router: ListSeriesRoutingLogic
    
    // MARK: - Private properties
    
    private var contentView: ListSeriesViewProtocol?
    
    // MARK: Initialization
    
    init(interactor: ListSeriesBusinessLogic, router: ListSeriesRoutingLogic) {
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
        view = ListSeriesView()
        contentView = view as? ListSeriesViewProtocol
        contentView?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.onViewDidLoad()
    }
}

// MARK: ListSeriesDisplayLogic

extension ListSeriesViewController: ListSeriesDisplayLogic {
    func displaySeriesList(_ data: [ListSeries.ViewModel]) {
        contentView?.showSeriesList(data)
    }
    
    func displayErrorState() {
        contentView?.showErrorView()
    }
}

// MARK: ListSeriesViewDelegate

extension ListSeriesViewController: ListSeriesViewDelegate {
    func fetchMoreData() {
        interactor.loadMoreData()
    }
    
    func didSelectSeries(id: Int) {
        router.goToSeriesDetails(id: id)
    }
    
    func didChangeSearchQuery(_ query: String) {
        interactor.searchSeries(query: query)
    }
    
    func reloadData() {
        interactor.onViewDidLoad()
    }
}
