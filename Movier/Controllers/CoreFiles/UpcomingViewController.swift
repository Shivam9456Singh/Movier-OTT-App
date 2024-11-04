//
//  UpcomingViewController.swift
//  Movier
//
//  Created by Shivam Kumar on 14/08/24.
//

import UIKit

class UpcomingViewController: UIViewController {
    private var titles: [Title] = [Title]()
    private var detailViewModel : DetailViewModel?
    
    let upcomingDetailView = DetailView()
    
    private let upcomingTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Coming soon"
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }

    private func fetchUpcoming(){
        APICaller.shared.getUpcomingMovies{ [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async{
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: ( title.original_title ?? title.original_name) ?? "Unknown Title Name", posterURL: title.poster_path ?? ""))
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let title = titles[indexPath.row]
        
        let detailViewModel = DetailViewModel(id: title.id, contentType: title.media_type, movieName: title.original_name, movieTitle: title.original_title, movieImagePath: title.poster_path, movieOverview: title.overview, movieVoteCount: title.vote_count, movieReleaseDate: title.release_date, movieVoteAverage: title.vote_average, tvairDate: title.first_air_date, movieAdult: title.adult, movieLanguage: title.original_language)
        detailVC.configure(with: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
