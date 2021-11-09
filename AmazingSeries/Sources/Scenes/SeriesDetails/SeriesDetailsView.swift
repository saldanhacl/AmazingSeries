//
//  SeriesDetailsView.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

protocol SeriesDetailsViewProtocol {
    var delegate: SeriesDetailsViewDelegate? { get set }
    
    func showData(_ data: SeriesDetails.ViewModel)
    func showSeasonsData(_ data: [Episodes.ViewModel.Season])
}

protocol SeriesDetailsViewDelegate: AnyObject {
    func didSelectEpisode(_ data: Episodes.ViewModel.Episode)
}

final class SeriesDetailsView: CodedView {
    
    enum Section: Int, CaseIterable {
        case header
        case summary
        case schedule
        case seasons
    }
    
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
        view.contentMode = .scaleAspectFill
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
    
    private lazy var pageTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        view.allowsSelection = false
        view.backgroundColor = .clear
        view.contentInsetAdjustmentBehavior = .never
        view.contentInset = UIEdgeInsets(top: Constants.bannerHeight, left: .zero, bottom: .zero, right: .zero)
        view.register(DetailHeaderTableViewCell.self, forCellReuseIdentifier: DetailHeaderTableViewCell.className)
        view.register(DetailDescriptionTableViewCell.self, forCellReuseIdentifier: DetailDescriptionTableViewCell.className)
        view.register(DetailSeasonTableViewCell.self, forCellReuseIdentifier: DetailSeasonTableViewCell.className)
        return view
    }()
    
    // MARK: Constraints
    
    private lazy var posterHeightConstraint: NSLayoutConstraint = {
        posterImageView.heightAnchor.constraint(equalToConstant: Constants.bannerHeight)
    }()
    
    // MARK: Dependencies
    
    weak var delegate: SeriesDetailsViewDelegate?
    
    // MARK: Private properties
    
    private var detailsViewModel: SeriesDetails.ViewModel = .empty()
    private var seasonsViewModel: [Episodes.ViewModel.Season] = []
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pageTableView.performBatchUpdates {}
    }
    
    // MARK: Coded View
    
    override func buildHierarchy() {
        addSubview(posterImageView)
        addSubview(gradientView)
        addSubview(pageTableView)
    }

    override func setupConstraints() {
        constrainPosterImageView()
        constrainPageTableView()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .black
    }
    
    private func constrainPosterImageView() {
        posterImageView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([posterHeightConstraint])
    }
    
    private func constrainPageTableView() {
        pageTableView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            paddingLeading: 16.0,
            paddingTrailing: 16.0
        )
    }
}

// MARK: UITableViewDataSource

extension SeriesDetailsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section(rawValue: section)
        switch section {
        case .header, .summary, .schedule:
            return 1
        case .seasons:
            return seasonsViewModel.count
        case .none:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCellFor(indexPath)
        return cell
    }
    
    // MARK: Private methods
    
    private func getCellFor(_ indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .header:
            let cell = pageTableView.dequeueReusableCell(with: DetailHeaderTableViewCell.self, for: indexPath)
            cell.setupData(title: detailsViewModel.name, genres: detailsViewModel.genres, imageURL: detailsViewModel.posterURL)
            return cell
        case .summary:
            let cell = pageTableView.dequeueReusableCell(with: DetailDescriptionTableViewCell.self, for: indexPath)
            cell.setupData(description: detailsViewModel.summary)
            return cell
        case .schedule:
            let cell = pageTableView.dequeueReusableCell(with: DetailDescriptionTableViewCell.self, for: indexPath)
            cell.setupData(description: detailsViewModel.schedule)
            return cell
        case .seasons:
            let seasonViewModel = seasonsViewModel[indexPath.row]
            let cell = pageTableView.dequeueReusableCell(with: DetailSeasonTableViewCell.self, for: indexPath)
            cell.setupData(seasonViewModel)
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: UITableViewDelegate

extension SeriesDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = Section(rawValue: section)
        let view = DetailSectionHeaderView()
        let title: String

        switch section {
        case .summary:
            title = "Summary"
        case .schedule:
            title = "Schedule"
        case .seasons:
            title = "Episodes"
        default:
            return nil
        }
        
        view.setupData(title: title)
        return view
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let contentY = -scrollView.contentOffset.y
//        posterHeightConstraint.constant = contentY
    }
}

// MARK: SeriesDetailsViewProtocol

extension SeriesDetailsView: DetailSeasonTableViewCellDelegate {
    func updateHeight() {
        pageTableView.performBatchUpdates {}
    }
    
    func didSelectEpisode(_ data: Episodes.ViewModel.Episode) {
        delegate?.didSelectEpisode(data)
    }
}
    
// MARK: SeriesDetailsViewProtocol

extension SeriesDetailsView: SeriesDetailsViewProtocol {
    func showData(_ data: SeriesDetails.ViewModel) {
        posterImageView.fetchImage(with: data.posterURL, placeholder: nil, imageDownloader: imageDownloader)
        detailsViewModel = data
        pageTableView.reloadData()
    }
    
    func showSeasonsData(_ data: [Episodes.ViewModel.Season]) {
        seasonsViewModel = data
        pageTableView.reloadSections([Section.seasons.rawValue], with: .automatic)
    }
}
