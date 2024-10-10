//
//  DetailView.swift
//  Movier
//
//  Created by Shivam Kumar on 09/10/24.
//

import Foundation
import UIKit

class DetailView : UIView {
    
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let playImageButton : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "play.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.7
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let movieImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let movieTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25,weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    let voteStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let star1 : UIImageView = {
        let imageView = UIImageView()
        imageView.sizeThatFits(CGSize(width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow).withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let star2 : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow).withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let star3 : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow).withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let star4 : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow).withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    let star5 : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.filled")?.withTintColor(.systemYellow).withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let star6 : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.leadinghalf.filled")?.withTintColor(.systemYellow).withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true
        return imageView
    }()

    let movieVoteLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray4
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let movieOverViewLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16,weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let verticalStackView : UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let horizontalStackView1 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
         stackView.spacing = 10
         stackView.alignment = .fill
         stackView.distribution = .fillEqually
         return stackView
    }()
    
    let horizontalStackView2 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
         stackView.spacing = 10
         stackView.alignment = .fill
         stackView.distribution = .fillEqually
         return stackView
    }()
    
    let horizontalStackView3 : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
         stackView.spacing = 10
         stackView.alignment = .fill
         stackView.distribution = .fillEqually
         return stackView
    }()
   
    let mediaType : UILabel = {
        let label = UILabel()
        label.text = "Media Type : "
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15,weight: .medium)
        return label
    }()
    
    let mediaTypeValue : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15,weight: .light)
        return label
    }()
    
    let ratings : UILabel = {
        let label = UILabel()
        label.text = "TMDB Rating : "
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15,weight: .medium)
        return label
    }()
    
    let ratingsValue : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15,weight: .light)
        return label
    }()
    
    let releaseDate : UILabel = {
        let label = UILabel()
        label.text = "Released On : "
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15,weight: .medium)
        return label
    }()
    
    let releaseDateValue : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15,weight: .light)
        return label
    }()
    
    
    let tableHeader : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Watch Trailer and more"
        label.font = .systemFont(ofSize: 20,weight: .medium)
        return label
    }()
    
    let tableView : UITableView = {
        let tableView  = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieImageView)
        movieImageView.addSubview(playImageButton)
        
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(voteStackView)
        contentView.addSubview(movieVoteLabel)
        contentView.addSubview(movieOverViewLabel)
        contentView.addSubview(tableHeader)
        contentView.addSubview(tableView)
        
        contentView.addSubview(verticalStackView)
        horizontalStackView1.addArrangedSubview(mediaType)
        horizontalStackView1.addArrangedSubview(mediaTypeValue)
        
        verticalStackView.addArrangedSubview(horizontalStackView1)
        
        horizontalStackView2.addArrangedSubview(ratings)
        horizontalStackView2.addArrangedSubview(ratingsValue)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        
        horizontalStackView3.addArrangedSubview(releaseDate)
        horizontalStackView3.addArrangedSubview(releaseDateValue)
        verticalStackView.addArrangedSubview(horizontalStackView3)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieImageView.heightAnchor.constraint(equalToConstant: 500),
            
            playImageButton.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor),
            playImageButton.centerXAnchor.constraint(equalTo: movieImageView.centerXAnchor),
            playImageButton.widthAnchor.constraint(equalToConstant: 100),
            playImageButton.heightAnchor.constraint(equalToConstant: 100),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant: 20),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            movieVoteLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 20),
            movieVoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieVoteLabel.widthAnchor.constraint(equalToConstant: 200),
            movieVoteLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            voteStackView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 20),
            voteStackView.leadingAnchor.constraint(equalTo: movieVoteLabel.trailingAnchor, constant: 10),
            voteStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            movieOverViewLabel.topAnchor.constraint(equalTo: voteStackView.bottomAnchor, constant: 20),
            movieOverViewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieOverViewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            
            verticalStackView.topAnchor.constraint(equalTo: movieOverViewLabel.bottomAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            tableHeader.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 20),
            tableHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            tableHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: tableHeader.bottomAnchor,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            tableView.heightAnchor.constraint(equalToConstant: 300),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
   
}
