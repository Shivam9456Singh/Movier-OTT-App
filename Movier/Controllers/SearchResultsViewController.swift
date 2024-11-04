//
//  SearchResultsViewController.swift
//  Movier
//
//  Created by Shivam Kumar on 23/10/24.
//

import Foundation
import UIKit

protocol SearchResultViewControllerProtocol : AnyObject {
    func didSelectCellItem(with viewModel : DetailViewModel)
}

class SearchResultsViewController : UIViewController {
    
    public var titles : [Title] = [Title]()
    weak var delegate : SearchResultViewControllerProtocol?
    
    public let searchResultsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    
}


extension SearchResultsViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = titles[indexPath.item]
        let detailViewModel = DetailViewModel(id: movie.id, contentType: movie.media_type, movieName: movie.original_name, movieTitle: movie.original_title, movieImagePath: movie.poster_path, movieOverview: movie.overview, movieVoteCount: movie.vote_count, movieReleaseDate: movie.release_date, movieVoteAverage: movie.vote_average, tvairDate: movie.first_air_date, movieAdult: movie.adult, movieLanguage: movie.original_language)
        delegate?.didSelectCellItem(with: detailViewModel)
    }
}
