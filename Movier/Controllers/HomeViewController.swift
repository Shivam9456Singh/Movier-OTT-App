//
//  HomeViewController.swift
//  Movier
//
//  Created by Shivam Kumar on 14/08/24.
//

import UIKit

enum Sections: Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    let heroHeaderView = HeroHeaderUIView()
    
    let sectionTitles: [String] = ["Trending movies", "Trending Tv", "Popular", "Upcoming movies", "Top rated"]
    
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
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        homeFeedTable.tableHeaderView = headerView
        homeFeedTable.showsVerticalScrollIndicator = false
        configureNavbar()
    }
    
    
    private func configureNavbar(){
        var image = UIImage(named: "movier")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.circle.fill"), style: .done, target: self, action: nil)
        ]
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
