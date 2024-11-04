//
//  CollectionViewTableViewCell.swift
//  Movier
//
//  Created by Shivam Kumar on 14/08/24.
//

import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func collectionViewCellDidTapCell(_ cell : CollectionViewTableViewCell, viewModel : DetailViewModel)
}


class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    private var titles: [Title] = [Title]()
    
    weak var delegate : CollectionViewCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 144, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    required init?(coder: NSCoder)
    {
     fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
   
    public func configure(with titles: [Title]){
        self.titles = titles
        DispatchQueue.main.async {[weak self ] in
            self?.collectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath : IndexPath){
        
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].poster_path else{
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 1.0) {
            cell.transform = CGAffineTransform.identity
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = titles[indexPath.row]
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let detailViewModel = DetailViewModel(id: title.id, contentType: title.media_type, movieName: title.original_name, movieTitle: title.original_title, movieImagePath: title.poster_path, movieOverview: title.overview, movieVoteCount: title.vote_count, movieReleaseDate: title.release_date, movieVoteAverage: title.vote_average, tvairDate: title.first_air_date,movieAdult: title.adult, movieLanguage: title.original_language)
        
        delegate?.collectionViewCellDidTapCell(self, viewModel: detailViewModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPath: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let downloadAction = UIAction(title: "Download", subtitle: "save to downloads", image: UIImage(systemName: "square.and.arrow.down")?.withTintColor(.red, renderingMode: .alwaysOriginal), identifier: nil, discoverabilityTitle: nil, state: .off) {[weak self] _ in
                self?.downloadTitleAt(indexPath: indexPath)
            }
            let playAction = UIAction(title: "Play now", subtitle: "watch this thriller", image: UIImage(systemName: "play.circle")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                print("Play now")
            }
            let infoAction = UIAction(title: "Info", subtitle: "get movie details and more", image: UIImage(systemName: "info.circle")?.withTintColor(.white,renderingMode: .alwaysOriginal), identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                print("Play now")
            }
            return UIMenu(title: "" , image: nil, identifier: nil, options: .displayInline, children: [infoAction,playAction,downloadAction])
        }
        return config
    }
    
}
