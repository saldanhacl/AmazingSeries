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
    
    // MARK: Dependencies
    
    @Dependency private var imageDownloader: ImageDownloaderProtocol
    
    // MARK: View Elements
    
    private let coverImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 12.0
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return view
    }()
    
    private let episodeInfoLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    private let summaryLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    // MARK: CodedView
    
    override func buildHierarchy() {
        addSubview(contentView)
        contentView.addSubview(coverImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(episodeInfoLabel)
        contentView.addSubview(summaryLabel)
    }
    
    override func setupConstraints() {
        constrainCoverImageView()
        constrainContentView()
        constrainNameLabel()
        constrainEpisodeInfoLabel()
        constrainSummary()
    }
    
    private func constrainCoverImageView() {
        coverImageView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 24.0,
            paddingLeading: 24.0,
            paddingTrailing: 24.0,
            height: 200
        )
    }
    
    private func constrainContentView() {
        contentView.fillSuperview(
            paddingTop: 24.0, paddingLeading: 24.0, paddingBottom: 24.0, paddingTrailing: 24.0
        )
    }
    
    private func constrainNameLabel() {
        nameLabel.anchor(
            top: coverImageView.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 16.0
        )
    }
    
    private func constrainEpisodeInfoLabel() {
        episodeInfoLabel.anchor(
            top: nameLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 8.0
        )
    }
    
    private func constrainSummary() {
        summaryLabel.anchor(
            top: episodeInfoLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 16.0
        )
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .black
    }
}

// MARK: EpisodeDetailsViewProtocol

extension EpisodeDetailsView: EpisodeDetailsViewProtocol {
    func showViewData(_ data: EpisodeDetails.ViewModel) {
        coverImageView.fetchImage(with: data.cover, placeholder: nil, imageDownloader: imageDownloader)
        
        nameLabel.text = data.name
        episodeInfoLabel.text = "\(data.season) - Episode \(data.number)"
        summaryLabel.renderAsHTML(data.summary, with: UIFont.systemFont(ofSize: 16, weight: .semibold), color: .white)
    }
}
