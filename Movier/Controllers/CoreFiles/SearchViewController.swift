//
//  SearchViewController.swift
//  Movier
//
//  Created by Shivam Kumar on 14/08/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles : [Title] = [Title]()
    
    private let discoverTable: UITableView  = {
        let table  =  UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private let searchController : UISearchController = {
        let searchResultVC = SearchResultsViewController()
        let controller = UISearchController(searchResultsController: searchResultVC)
        controller.searchBar.placeholder = " Search"
        controller.searchBar.searchBarStyle = .prominent
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(discoverTable)
        view.backgroundColor = .systemBackground
        title = "Search"
        discoverTable.delegate = self
        discoverTable.dataSource = self
        fetchDiscoverMovies()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        if let searchResultVC = searchController.searchResultsController as? SearchResultsViewController {
            searchResultVC.delegate = self
        }
        
    }
    
    private func fetchDiscoverMovies(){
        APICaller.shared.getTopRated{[weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async{
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
}

extension SearchViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "Unknown Name", posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = titles[indexPath.row]
        let detailVC = DetailViewController()
        
        let viewModel = DetailViewModel(id: title.id, contentType: title.media_type, movieName: title.original_name, movieTitle: title.original_title, movieImagePath: title.poster_path, movieOverview: title.overview, movieVoteCount: title.vote_count, movieReleaseDate: title.release_date, movieVoteAverage: title.vote_average, tvairDate: title.first_air_date, movieAdult: title.adult, movieLanguage: title.original_language)
        
        detailVC.configure(with: viewModel)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}

extension SearchViewController : SearchResultViewControllerProtocol {
    
    func didSelectCellItem(with viewModel: DetailViewModel) {
        DispatchQueue.main.async {[weak self] in
            let detailVC = DetailViewController()
            detailVC.configure(with: viewModel)
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
       
    }
}
