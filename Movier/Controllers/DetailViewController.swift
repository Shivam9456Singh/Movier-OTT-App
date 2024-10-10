//
//  DetailViewController.swift
//  Movier
//
//  Created by Shivam Kumar on 09/10/24.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {
    
    let detailView = DetailView()
    
    private var viewModel : DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDetailView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        detailView.tableView.dataSource = self
        detailView.tableView.delegate = self
        detailView.tableView.register(VideoTableCell.self, forCellReuseIdentifier: VideoTableCell.identifier)
        detailView.tableView.showsVerticalScrollIndicator = false
        detailView.tableView.layer.cornerRadius = 20
        detailView.tableView.separatorStyle = .none
    }
    
    private func setupDetailView(){
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    

    
    func configure(with viewModel : DetailViewModel){
        self.viewModel = viewModel
        detailView.movieImageView.image = UIImage(named: viewModel.movieImagePath ?? "image")
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.movieImagePath ?? "image")") else { return }
        
        detailView.movieImageView.sd_setImage(with: url, completed: nil)
        
        detailView.movieTitleLabel.text =  "\(viewModel.movieName ?? viewModel.movieTitle ?? "Not Available")"
        detailView.movieVoteLabel.text = "Total votes : " + String(viewModel.movieVoteCount)
        detailView.movieOverViewLabel.text = "\(viewModel.movieOverview ?? "Not Available")"
        detailView.mediaTypeValue.text = viewModel.contentType ?? "movie"
        detailView.ratingsValue.text = String(viewModel.movieVoteAverage)
        detailView.releaseDateValue.text = viewModel.movieReleaseDate ?? viewModel.tvairDate
        
        if  Int(viewModel.movieVoteCount) > 100 && Int(viewModel.movieVoteCount) <= 500 {
            detailView.voteStackView.addArrangedSubview(detailView.star1)
            detailView.voteStackView.addArrangedSubview(detailView.star2)
            detailView.voteStackView.addArrangedSubview(detailView.star6)
        }
        else if Int(viewModel.movieVoteCount) > 500 && Int(viewModel.movieVoteCount) <= 1000  {
            detailView.voteStackView.addArrangedSubview(detailView.star1)
            detailView.voteStackView.addArrangedSubview(detailView.star2)
            detailView.voteStackView.addArrangedSubview(detailView.star3)
            detailView.voteStackView.addArrangedSubview(detailView.star4)
            detailView.voteStackView.addArrangedSubview(detailView.star6)
        }
        else if Int(viewModel.movieVoteCount) > 1000 {
            detailView.voteStackView.addArrangedSubview(detailView.star1)
            detailView.voteStackView.addArrangedSubview(detailView.star2)
            detailView.voteStackView.addArrangedSubview(detailView.star3)
            detailView.voteStackView.addArrangedSubview(detailView.star4)
            detailView.voteStackView.addArrangedSubview(detailView.star5)
        }
        else{
            detailView.voteStackView.addArrangedSubview(detailView.star1)
            detailView.voteStackView.addArrangedSubview(detailView.star6)
        }
    }
    
    
}

extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableCell.identifier) as? VideoTableCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
