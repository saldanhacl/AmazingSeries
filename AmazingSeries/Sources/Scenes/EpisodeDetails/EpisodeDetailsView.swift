//
//  EpisodeDetailsView.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 08/11/21.
//

import Foundation
import UIKit

protocol EpisodeDetailsViewProtocol {
    func showViewData(_ data: EpisodeDetails.ViewModel)
}

final class EpisodeDetailsView: CodedView {
    
    // MARK: View Elements
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Cow"
        return view
    }()
    
    override func buildHierarchy() {
        addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        titleLabel.fillSuperview()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .black
    }
    
}
