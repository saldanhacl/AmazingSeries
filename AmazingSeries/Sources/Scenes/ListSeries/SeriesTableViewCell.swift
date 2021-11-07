//
//  SeriesTableViewCell.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

final class SeriesTableViewCell: CodedTableViewCell {
    
    // MARK: View Elements
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        constrainTitleLabel()
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor
        )
    }
    
    // MARK: Internal methods
    
    func setupData(title: String) {
        titleLabel.text = title
    }
}
