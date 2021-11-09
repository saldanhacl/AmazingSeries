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
        view.spacing = 8.0
        view.distribution = .fill
        
        return view
    }()
    
    private let roundedBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        return view
    }()
    
    private lazy var collapaseButton: UIButton = {
        let view = UIButton()
        view.tintColor = .white
        view.setImage(UIImage(named: "chevron_down"), for: .normal)
        view.setImage(UIImage(named: "chevron_up"), for: .selected)
        view.imageEdgeInsets = UIEdgeInsets(top: .zero, left: (bounds.width - 24), bottom: .zero, right: .zero)
        view.addTarget(self, action: #selector(seasonTitleTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        return view
    }()
    
    private lazy var episodesTableView: ContentSizedTableView = {
        let view = ContentSizedTableView()
        view.isHidden = true
        view.dataSource = self
        view.delegate = self
        view.isScrollEnabled = false
        view.backgroundColor = .clear
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
            collapaseButton.isSelected = showEpisodes
        }
    }
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(titleLabel)
        roundedBackgroundView.addSubview(collapaseButton)
        contentStackView.addArrangedSubview(episodesTableView)
    }
    
    override func setupConstraints() {
        constrainContentStackView()
        constrainTitleLabel()
        constrainCollapseButton()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .clear
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
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: roundedBackgroundView.topAnchor,
            leading: roundedBackgroundView.leadingAnchor,
            bottom: roundedBackgroundView.bottomAnchor,
            paddingTop: 6.0,
            paddingLeading: 16.0,
            paddingBottom: 6.0
        )
    }
    
    private func constrainCollapseButton() {
        collapaseButton.fillSuperview()
    }
    
    // MARK: Internal methods
    
    func setupData(_ data: Episodes.ViewModel.Season) {
        titleLabel.text = data.name
        seasonViewModel = data
        episodesTableView.reloadData()
    }
    
    // MARK: Actions
    
    @objc private func seasonTitleTapped(_ sender: UIButton) {
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
        
        cell.setupData(title: episode.name, coverImageURL: episode.coverImage)
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
