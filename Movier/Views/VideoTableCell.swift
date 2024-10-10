//
//  VideoTableCell.swift
//  Movier
//
//  Created by Shivam Kumar on 10/10/24.
//

import Foundation
import UIKit
import AVFoundation

class VideoTableCell : UITableViewCell {
    
    static let identifier = "VideoTableCell"
    
    let containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .quaternarySystemFill
        return view
    }()
    
    let movieThumbnail : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "stree2")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let videoTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Watch the teaser now "
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let playImageButton : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "play.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func setupView(){
        contentView.addSubview(containerView)
        containerView.addSubview(movieThumbnail)
        containerView.addSubview(videoTitleLabel)
        movieThumbnail.addSubview(playImageButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            movieThumbnail.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 5),
            movieThumbnail.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 5),
            movieThumbnail.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
            movieThumbnail.widthAnchor.constraint(equalToConstant: 140),
            
            playImageButton.centerYAnchor.constraint(equalTo: movieThumbnail.centerYAnchor),
            playImageButton.centerXAnchor.constraint(equalTo: movieThumbnail.centerXAnchor),
            playImageButton.widthAnchor.constraint(equalToConstant: 50),
            playImageButton.heightAnchor.constraint(equalToConstant: 50),
            
            videoTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 5),
            videoTitleLabel.leadingAnchor.constraint(equalTo: movieThumbnail.trailingAnchor, constant: 10),
            videoTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -5),
            videoTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -5),
        ])
    }
}
