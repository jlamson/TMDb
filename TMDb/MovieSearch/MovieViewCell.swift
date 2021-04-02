//
//  MovieCellView.swift
//  TMDb
//
//  Created by Joshua Lamson on 3/5/21.
//

import Foundation
import UIKit

class MovieViewCell: UITableViewCell {
    
    static let identifier = "movieCellView"
    
    lazy var poster: UIImageView = {
        let it = UIImageView()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.contentMode = .scaleAspectFit
        return it
    }()
    
    lazy var title: UILabel = {
        let it = UILabel()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        return it
    }()
    
    lazy var descriptionText: UILabel = {
        let it = UILabel()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        it.numberOfLines = 3
        it.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return it
    }()
    
    var boundMovie: Movie?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutChildren()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Design
    
    private func layoutChildren() {
        let parent = contentView.layoutMarginsGuide
        
        contentView.addSubview(poster)
        NSLayoutConstraint.activate([
            poster.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            poster.topAnchor.constraint(equalTo: parent.topAnchor),
            poster.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            poster.heightAnchor.constraint(equalToConstant: 120),
            poster.widthAnchor.constraint(equalToConstant: 81)
        ])
        
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: parent.topAnchor, multiplier: 1),
            title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
        ])
        
        contentView.addSubview(descriptionText)
        NSLayoutConstraint.activate([
            descriptionText.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: title.lastBaselineAnchor, multiplier: 1),
            descriptionText.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 8),
            descriptionText.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            parent.bottomAnchor.constraint(equalToSystemSpacingBelow: descriptionText.lastBaselineAnchor, multiplier: 1)
        ])
    }
    
    // MARK: - Binding
    
    func bind(movie: Movie, usingImageResolver resolver: RemoteImageResolver) {
        boundMovie = movie
        title.text = movie.title
        descriptionText.text = movie.overview
        if let url = movie.posterImageUrl {
            resolver.load(imageAt: url) { [weak self] result in
                guard self?.boundMovie == movie else {
                    // If the bound Movie has changed, we can ignore this image.
                    return
                }
                
                switch result {
                case .success(let image):
                    self?.poster.image = image
                case .error(let error): // squash error for now
                    self?.poster.image = nil
                }
            }
        }
    }
}
