//
//  DetailDescriptionTableViewCell.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

final class DetailDescriptionTableViewCell: CodedTableViewCell {
    // MARK: View Elements
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        contentView.addSubview(descriptionLabel)
    }
    
    override func setupConstraints() {
        constrainDescriptionLabel()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .clear
    }
    

    private func constrainDescriptionLabel() {
        descriptionLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 16.0
        )
    }
    
    // MARK: Internal methods
    
    func setupData(description: String) {
        descriptionLabel.renderAsHTML(description, with: UIFont.systemFont(ofSize: 16, weight: .semibold), color: .white)        
    }
}
