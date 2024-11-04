//
//  UpcomingDetailViewController.swift
//  Movier
//
//  Created by Shivam Kumar on 23/10/24.
//

import Foundation

import UIKit

class UpcomingDetailViewController : UIViewController {
    
    let upcomingDetailView = DetailView()
    private var viewModel : DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingDetailView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.addSubview(upcomingDetailView)
        
        NSLayoutConstraint.activate([
            upcomingDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            upcomingDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            upcomingDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            upcomingDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        
    }
    
    func configure(with viewModel : DetailViewModel){
        func configure(with viewModel : DetailViewModel){
            self.viewModel = viewModel
            upcomingDetailView.movieImageView.image = UIImage(named: viewModel.movieImagePath ?? "image")
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.movieImagePath ?? "image")") else { return }
            
            upcomingDetailView.movieImageView.sd_setImage(with: url, completed: nil)
            
            upcomingDetailView.movieTitleLabel.text =  "\(viewModel.movieName ?? viewModel.movieTitle ?? "Not Available")"
            upcomingDetailView.movieVoteLabel.text = "Total votes : " + String(viewModel.movieVoteCount)
            upcomingDetailView.movieOverViewLabel.text = "\(viewModel.movieOverview ?? "Not Available")"
            upcomingDetailView.mediaTypeValue.text = viewModel.contentType ?? "movie"
            upcomingDetailView.ratingsValue.text = String(viewModel.movieVoteAverage)
            upcomingDetailView.releaseDateValue.text = viewModel.movieReleaseDate ?? viewModel.tvairDate
            
            if  Int(viewModel.movieVoteCount) > 100 && Int(viewModel.movieVoteCount) <= 500 {
                upcomingDetailView.voteStackView.addArrangedSubview(upcomingDetailView.star1)
                upcomingDetailView.voteStackView.addArrangedSubview(upcomingDetailView.star2)
                upcomingDetailView.voteStackView.addArrangedSubview(upcomingDetailView.star6)
            }
            else if Int(viewModel.movieVoteCount) > 500 && Int(viewModel.movieVoteCount) <= 1000  {
                upcomingDetailView.voteStackView.addArrangedSubview(upcomingDetailView.star1)
                upcomingDetailView.voteStackView.addArrangedSubview(upcomingDetailView.star2)
                upcomingDetailView.voteStackView.addArrangedSubview(upcomingDetailView.star3)
                upcomingDetailView.voteStackView.addArrangedSubview(upcomingDetailView.star4)
                upcomingDetailView.voteStackView.addArrangedSubview(upcomingDetailView.star6)
            }
            else if Int(viewModel.movieVoteCount) > 1000 {
                upcomingDetailView.voteStackView.addArrangedSubview(upcomingDetailView.star5)
            }
            else{
                upcomingDetailView.voteStackView.addArrangedSubview(upcomingDetailView.star1)
                upcomingDetailView.voteStackView.addArrangedSubview(upcomingDetailView.star6)
            }
        }
        
        
    }
}
