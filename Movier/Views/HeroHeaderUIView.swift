//
//  HeroHeaderUIView.swift
//  Movier
//
//  Created by Shivam Kumar on 14/08/24.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
         return button
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
     let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
         imageView.image = UIImage(named: "stree2")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
 
    private func applyConstraints(){
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downloadButonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -160),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
            
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
