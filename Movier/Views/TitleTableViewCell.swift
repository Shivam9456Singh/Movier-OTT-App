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
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.cirlce"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let titlesPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier resuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: resuseIdentifier)
        contentView.addSubview(titlesPosterUIImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        applyConstraints()
    }
    
    private func applyConstraints(){
        let titlesPosterUIImageViewConstriants = [
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let playTitleButton = [
            playTitleButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            playTitleButton.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor,constant: 10),
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstriants)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButton)
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
