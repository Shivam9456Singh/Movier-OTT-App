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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = titles[indexPath.row]
        
        let detailViewModel = DetailViewModel(contentType: title.media_type, movieName: title.original_name, movieTitle: title.original_title, movieImagePath: title.poster_path, movieOverview: title.overview, movieVoteCount: title.vote_count, movieReleaseDate: title.release_date, movieVoteAverage: title.vote_average, tvairDate: title.first_air_date)
        
        delegate?.collectionViewCellDidTapCell(self, viewModel: detailViewModel)
    }
    
    
    
}
