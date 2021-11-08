//
//  DetailHeaderTableViewCell.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

final class DetailHeaderTableViewCell: CodedTableViewCell {
    
    // MARK: Constants
    
    private struct Constants {
        static let bannerHeight: CGFloat = 360.0
        static let gradientViewHeight: CGFloat = bannerHeight / 3
    }
    
    // MARK: Dependencies
    
    @Dependency private var imageDownloader: ImageDownloaderProtocol
    
    // MARK: View Elements
    
    private let posterImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        return view
    }()
    
    private let gradientView: UIView = {
        let view = UIView()
        
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = CGRect(
            x: .zero,
            y: Constants.bannerHeight - Constants.gradientViewHeight,
            width: UIScreen.main.bounds.width,
            height: Constants.gradientViewHeight
        )
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.3).cgColor, UIColor.black.withAlphaComponent(0.8).cgColor,  UIColor.black.cgColor]
        gradientMaskLayer.locations = [0.0, 0.3, 0.6, 1.0]
        view.layer.addSublayer(gradientMaskLayer)
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        return view
    }()
    
    private let genresLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genresLabel)
    }
    
    override func setupConstraints() {
        constrainPosterImageView()
        constrainTitleLabel()
        constrainGenresLabel()
    }
    
    private func constrainPosterImageView() {
        posterImageView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingLeading: -16.0,
            paddingTrailing: -16.0,
            height: Constants.bannerHeight
        )
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: posterImageView.bottomAnchor,
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
        posterImageView.fetchImage(with: imageURL, placeholder: nil, imageDownloader: imageDownloader)
        
        titleLabel.text = title
        genresLabel.text = genres
    }
}
