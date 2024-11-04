//
//  HeroHeaderUIView.swift
//  Movier
//
//  Created by Shivam Kumar on 14/08/24.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    public let downloadButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .systemRed
        button.configuration?.image = UIImage(systemName: "arrowshape.down.fill")?.withRenderingMode(.alwaysOriginal)
        button.configuration?.title = "Download"
        button.configuration?.imagePadding = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
         return button
    }()
    
    public let playButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .systemRed
        button.configuration?.image = UIImage(systemName: "play.circle")?.withRenderingMode(.alwaysOriginal)
        button.configuration?.title = "Play"
        button.configuration?.imagePadding = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
     let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
         imageView.preferredImageDynamicRange = .high
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
 
    
    public func configure(with model : TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        heroImageView.sd_setImage(with: url,completed: nil)
    }
    private func applyConstraints(){
        let playButtonConstraints = [
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ]
        
        let downloadButonConstraints = [
            downloadButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 20),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
        ]
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButonConstraints)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
