//
//  DetailEpisodeTableViewCell.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

final class DetailEpisodeTableViewCell: CodedTableViewCell {
    
    // MARK: Dependencies
    
    @Dependency private var imageDownloader: ImageDownloaderProtocol
    
    // MARK: View Elements
    
    private let coverImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 8.0
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        constrainPosterImageView()
        constrainTitleLabel()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func constrainPosterImageView() {
        coverImageView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            paddingTop: 8.0,
            paddingBottom: 8.0,
            width: 80,
            height: 60
        )
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: coverImageView.topAnchor,
            leading: coverImageView.trailingAnchor,
            trailing: contentView.trailingAnchor,
            paddingLeading: 8.0
        )
    }
    
    // MARK: Internal methods
    
    func setupData(title: String, coverImageURL: String?) {
        titleLabel.text = title
        
        if let imageURL = coverImageURL {
            coverImageView.fetchImage(with: imageURL, placeholder: nil, imageDownloader: imageDownloader)
        }
    }
}
