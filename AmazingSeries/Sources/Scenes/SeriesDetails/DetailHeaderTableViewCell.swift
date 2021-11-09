//
//  DetailHeaderTableViewCell.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

final class DetailHeaderTableViewCell: CodedTableViewCell {
    
    // MARK: View Elements
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return view
    }()
    
    private let genresLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(genresLabel)
    }
    
    override func setupConstraints() {
        constrainTitleLabel()
        constrainGenresLabel()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .clear
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor
        )
    }
    
    private func constrainGenresLabel() {
        genresLabel.anchor(
            top: titleLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 8.0
        )
    }
    
    // MARK: Internal methods
    
    func setupData(title: String, genres: String, imageURL: String) {        
        titleLabel.text = title
        genresLabel.text = genres
    }
}
