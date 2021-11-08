//
//  SeriesTableViewCell.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

final class SeriesTableViewCell: CodedTableViewCell {
    
    // MARK: Dependencies
    
    @Dependency private var imageDownloader: ImageDownloaderProtocol
    
    // MARK: View Elements
    
    private let posterImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        constrainPosterImageView()
        constrainTitleLabel()
    }
    
    private func constrainPosterImageView() {
        posterImageView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            width: 100,
            height: 140
        )
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: posterImageView.topAnchor,
            leading: posterImageView.trailingAnchor,
            trailing: contentView.trailingAnchor,
            paddingLeading: 8.0
        )
    }
    
    // MARK: Internal methods
    
    func setupData(title: String, posterImageURL: String?) {
        titleLabel.text = title
        
        if let imageURL = posterImageURL {
            posterImageView.fetchImage(with: imageURL, placeholder: nil, imageDownloader: imageDownloader)
        }
    }
}
