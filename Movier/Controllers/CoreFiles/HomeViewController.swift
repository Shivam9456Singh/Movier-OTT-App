//
//  HomeViewController.swift
//  Movier
//
//  Created by Shivam Kumar on 14/08/24.
//

import UIKit
import Foundation
import SystemConfiguration

enum Sections: Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    let heroHeaderView = HeroHeaderUIView()
    
    let sectionTitles: [String] = ["Trending movies", "Web series", "Popular", "Upcoming movies", "Top rated"]
    
    private var randomTrendingMovie : Title?
    
    var headerView : HeroHeaderUIView?
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerId")
        table.separatorStyle = .none
        table.isUserInteractionEnabled = true
        table.backgroundColor = .clear
        return table
    }()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        homeFeedTable.frame = view.bounds
        configureNavbar()
        title = "Home"
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        
        homeFeedTable.tableHeaderView = headerView
        homeFeedTable.showsVerticalScrollIndicator = false
        configureNavbar()
        configureHeroHeaderView()
        homeFeedTable.tableHeaderView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openDetailViewController)))
        
        headerView?.playButton.addTarget(self, action: #selector(playDownloadButtonClicked), for: .touchUpInside)
        headerView?.downloadButton.addTarget(self, action: #selector(playDownloadButtonClicked), for: .touchUpInside)
        
    }
    

    @objc func playDownloadButtonClicked(_ sender : UIButton){
        sender.configuration?.baseBackgroundColor = .systemGreen
        sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        switch sender.titleLabel?.text {
        case "play":
            UIView.animate(withDuration: 0.5) {
                sender.transform = CGAffineTransform.identity
                sender.configuration?.baseBackgroundColor = .systemRed
            }
        case "Download":
            UIView.animate(withDuration: 0.5) {
                sender.transform = CGAffineTransform.identity
            }
        default:
            sender.configuration?.baseBackgroundColor = .systemRed
        }
       
        
        if sender.titleLabel?.text == "Download" {
            let center = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()
            content.title = "Downloaded \(randomTrendingMovie?.original_name ?? randomTrendingMovie?.original_title ?? "")"
            content.body = "Watch Now in the downloads"
            content.sound = .default
            content.userInfo = ["value" : "Data with local Notification"]
            let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(1))
            let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
            let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
            center.add(request) { (error) in
                if error != nil {
                    print("Error \(String(describing: error?.localizedDescription))")
                }
            }
            
            sender.configuration?.title = "Downloaded"
            sender.configuration?.image = UIImage(systemName: "checkmark")
        
        }
        else if sender.titleLabel?.text == "Play" {
            openDetailViewController(sender)
        }

    }
    
    
    private func configureHeroHeaderView(){
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                self.randomTrendingMovie = selectedTitle
                self.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? "" ))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
     
    }
    
    @objc func openDetailViewController(_ sender : AnyObject){
        guard let selectedRandomMovie = randomTrendingMovie else {return}
        let title = selectedRandomMovie
        let detailViewModel = DetailViewModel(id: title.id, contentType: title.media_type, movieName: title.original_name, movieTitle: title.original_title, movieImagePath: title.poster_path, movieOverview: title.overview, movieVoteCount: title.vote_count, movieReleaseDate: title.release_date, movieVoteAverage: title.vote_average, tvairDate: title.first_air_date,movieAdult: title.adult,movieLanguage: title.original_language)
        
        let detailVC = DetailViewController()
        detailVC.configure(with: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func configureNavbar(){
        var image = UIImage(named: "movier")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(reloadTableView))
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: #selector(openProfile)),
            UIBarButtonItem(image: UIImage(systemName: "play.circle.fill"), style: .done, target: self, action: #selector(openHistory))
        ]
    }

    @objc func openProfile(_ sender : UIBarButtonItem){
        let openUserProfileVC = UserProfileViewController()
        navigationController?.pushViewController(openUserProfileVC, animated: true)
    }
    
    @objc func openHistory(_ sender : UIBarButtonItem){
        print("Open History Button tapped")
    }
    
    @objc func reloadTableView(_ sender : UIBarButtonItem){
        self.homeFeedTable.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    
}

//MARK: - TableView Delegate Data Source

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell", for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        cell.delegate = self
        
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies{ result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs{ result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular{ result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies{result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated{result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = sectionTitles[section]
        return title.prefix(1).capitalized + title.dropFirst().lowercased()
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") else {
            return nil
        }

        header.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .systemRed
        return header
    }
    
    

}

extension HomeViewController : CollectionViewCellDelegate {
    func collectionViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: DetailViewModel) {
        let detailVC = DetailViewController()
            detailVC.configure(with : viewModel)
            self.navigationController?.pushViewController(detailVC, animated: true)
       
    }
    
    
    
}

extension HomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
