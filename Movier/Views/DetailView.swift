//
//  DetailView.swift
//  Movier
//
//  Created by Shivam Kumar on 09/10/24.
//

import Foundation
import UIKit
import WebKit

class DetailView : UIView {
    
    lazy var webView : WKWebView = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = [.all]
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.contentMode = .scaleToFill
        webView.clipsToBounds = true
        webView.backgroundColor = .systemBackground
        webView.layer.cornerRadius = 20
        return webView
    }()
    
    lazy var webView2 : WKWebView = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = [.all]
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.backgroundColor = .systemBackground
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.clipsToBounds = true
        return webView
    }()
  
    
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
    
    
    lazy var movieImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.isHidden = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
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
    
    let serverErrorLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15,weight: .regular)
        label.numberOfLines = 0
        label.text = "Server error in playing video."
        label.textAlignment = .center
        label.textColor = .systemRed
        label.isHidden = true
        return label
    }()
    
    let downloadButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "arrow.down.app"), for: .normal)
        button.tintColor = .systemRed
        button.clipsToBounds = true
        return button
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
    
    let cardView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        return view
    }()
    
    let tableHeader : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Watch Trailer and more"
        label.font = .systemFont(ofSize: 20,weight: .medium)
        return label
    }()
    
    let watchMovieButton : UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.title = "Watch now"
        button.configuration?.image = UIImage(systemName: "movieclapper")?.withRenderingMode(.alwaysOriginal)
        return button
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
        contentView.addSubview(webView)
        movieImageView.addSubview(serverErrorLabel)
        
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(downloadButton)
        contentView.addSubview(voteStackView)
        contentView.addSubview(movieVoteLabel)
        contentView.addSubview(movieOverViewLabel)
        contentView.addSubview(tableHeader)
        contentView.addSubview(webView2)
        contentView.addSubview(watchMovieButton)
        
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
            
            serverErrorLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant: -5),
            serverErrorLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: 10),
            
            webView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            webView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            webView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            webView.heightAnchor.constraint(equalToConstant: 500),
        
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant: 20),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieTitleLabel.trailingAnchor.constraint(equalTo: downloadButton.leadingAnchor, constant: -10),
            
            watchMovieButton.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10),
            watchMovieButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            downloadButton.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20),
            downloadButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            downloadButton.widthAnchor.constraint(equalToConstant: 30),
            downloadButton.heightAnchor.constraint(equalToConstant: 30),
            
            movieVoteLabel.topAnchor.constraint(equalTo: watchMovieButton.bottomAnchor, constant: 20),
            movieVoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieVoteLabel.widthAnchor.constraint(equalToConstant: 200),
            movieVoteLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            voteStackView.topAnchor.constraint(equalTo: watchMovieButton.bottomAnchor, constant: 20),
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
            
            webView2.topAnchor.constraint(equalTo: tableHeader.bottomAnchor, constant: 20),
            webView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            webView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            webView2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant:50),
            webView2.heightAnchor.constraint(equalToConstant: 700),
        ])
    }
   
}
