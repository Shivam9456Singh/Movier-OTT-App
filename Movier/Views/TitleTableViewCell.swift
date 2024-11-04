//
//  TitleTableViewCell.swift
//  Movier
//
//  Created by Shivam Kumar on 30/08/24.
//
import Foundation
import UIKit

protocol TableViewCellDelegate: AnyObject {
    func TableViewCellDidTapCell(_ cell : TitleTableViewCell, viewModel : DetailViewModel)
}

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    weak var delegate : TableViewCellDelegate?
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "play.circle")?.withTintColor(.white,renderingMode: .alwaysOriginal), for: .normal)
        button.clipsToBounds = true
        return button
    }()
    
    private let containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    private let titlesPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier resuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: resuseIdentifier)
        contentView.addSubview(containerView)
        containerView.addSubview(titlesPosterUIImageView)
        titlesPosterUIImageView.addSubview(playTitleButton)
        containerView.addSubview(titleLabel)
        applyConstraints()
    }
    
    private func applyConstraints(){
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            containerView.heightAnchor.constraint(equalToConstant: 300),
            
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 10),
            titlesPosterUIImageView.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 20),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 180),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -20),
        
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            playTitleButton.centerXAnchor.constraint(equalTo: titlesPosterUIImageView.centerXAnchor),
            playTitleButton.centerYAnchor.constraint(equalTo: titlesPosterUIImageView.centerYAnchor),
            playTitleButton.widthAnchor.constraint(equalToConstant: 50),
            playTitleButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    
    public func configure(with model: TitleViewModel){
   
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        titlesPosterUIImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    
}
