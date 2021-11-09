//
//  DetailSectionHeaderView.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

final class DetailSectionHeaderView: CodedView {
    // MARK: View Elements
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        constrainTitleLabel()
    }

    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
        )
    }
    
    // MARK: Internal methods
    
    func setupData(title: String) {
        titleLabel.text = title
    }
}
