//
//  ListSeriesViewController.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit


protocol ListSeriesDisplayLogic: AnyObject {
    
}

final class ListSeriesViewController: UIViewController {
    
    // MARK: Dependencies
    
    private let interactor: ListSeriesBusinessLogic
    
    // MARK: - Private properties
    
    private var contentView: ListSeriesViewProtocol?
    
    // MARK: Initialization
    
    init(interactor: ListSeriesBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        view = ListSeriesView()
        contentView = view as? ListSeriesViewProtocol
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
}

// MARK: ListSeriesDisplayLogic

extension ListSeriesViewController: ListSeriesDisplayLogic {
    
}
