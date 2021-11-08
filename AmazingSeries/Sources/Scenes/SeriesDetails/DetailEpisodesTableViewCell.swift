//
//  DetailEpisodesTableViewCell.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

final class DetailEpisodesTableViewCell: CodedTableViewCell {
    // MARK: View Elements
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        constrainTitleLabel()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .darkGray
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 16.0
        )
    }
    
    // MARK: Internal methods
    
    func setupData(title: String) {
        titleLabel.text = title
    }
}
