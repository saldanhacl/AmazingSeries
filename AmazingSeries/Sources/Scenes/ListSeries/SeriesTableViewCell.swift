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
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 8.0
        return view
    }()
        
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return view
    }()
    
    private let genresLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(ratingLabel)
    }
    
    override func setupConstraints() {
        constrainPosterImageView()
        constrainTitleLabel()
        constrainGenresLabel()
        constrainRatingLabel()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .black
    }
    
    private func constrainPosterImageView() {
        posterImageView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            paddingTop: 8.0,
            paddingBottom: 8.0,
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
    
    private func constrainGenresLabel() {
        genresLabel.anchor(
            top: titleLabel.bottomAnchor,
            leading: titleLabel.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 6.0
        )
    }
    
    private func constrainRatingLabel() {
        ratingLabel.anchor(
            top: genresLabel.bottomAnchor,
            leading: genresLabel.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 6.0
        )
    }
    
    // MARK: Internal methods
    
    func setupData(title: String, genres: String, rating: String, posterImageURL: String?) {
        titleLabel.text = title
        genresLabel.text = genres
        ratingLabel.text = rating
        
        if let imageURL = posterImageURL {
            posterImageView.fetchImage(with: imageURL, placeholder: nil, imageDownloader: imageDownloader)
        }
    }
}
