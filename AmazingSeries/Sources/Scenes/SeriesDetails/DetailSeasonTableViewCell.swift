//
//  DetailSeasonTableViewCell.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

protocol DetailSeasonTableViewCellDelegate: AnyObject {
    func updateHeight()
    func didSelectEpisode(_ data: Episodes.ViewModel.Episode)
}

final class DetailSeasonTableViewCell: CodedTableViewCell {
    // MARK: View Elements
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:))))
        return view
    }()
    
    private lazy var episodesTableView: ContentSizedTableView = {
        let view = ContentSizedTableView()
        view.isHidden = true
        view.dataSource = self
        view.delegate = self
        view.isScrollEnabled = false
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.setContentHuggingPriority(.required, for: .vertical)
        view.register(DetailEpisodeTableViewCell.self, forCellReuseIdentifier: DetailEpisodeTableViewCell.className)
        return view
    }()
    
    // MARK: Dependencies
    
    weak var delegate: DetailSeasonTableViewCellDelegate?
    
    // MARK: Private properties
    
    private var seasonViewModel: Episodes.ViewModel.Season?
    private var showEpisodes: Bool = false {
        didSet {
            episodesTableView.isHidden = !showEpisodes

        }
    }
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(episodesTableView)
    }
    
    override func setupConstraints() {
        constrainContentStackView()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .darkGray
    }
    
    private func constrainContentStackView() {
        contentStackView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 16.0
        )
    }
    
    // MARK: Internal methods
    
    func setupData(_ data: Episodes.ViewModel.Season) {
        titleLabel.text = data.name
        seasonViewModel = data
        episodesTableView.reloadData()
    }
    
    // MARK: Actions
    
    @objc private func labelTapped(_ sender: UITapGestureRecognizer) {
        showEpisodes = !showEpisodes
        delegate?.updateHeight()
    }
}

// MARK: UITableViewDataSource

extension DetailSeasonTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        seasonViewModel?.episodes.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let episode = seasonViewModel?.episodes[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(with: DetailEpisodeTableViewCell.self, for: indexPath)
        
        cell.setupData(title: episode.name, coverImageURL: episode.cover)
        return cell
    }
}

// MARK: UITableViewDelegate

extension DetailSeasonTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedEpisode = seasonViewModel?.episodes[indexPath.row] else { return }
        delegate?.didSelectEpisode(selectedEpisode)
    }
}
