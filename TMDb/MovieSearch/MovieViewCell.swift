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
        
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: parent.topAnchor, multiplier: 1),
            title.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
        ])
        
        contentView.addSubview(descriptionText)
        NSLayoutConstraint.activate([
            descriptionText.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: title.lastBaselineAnchor, multiplier: 1),
            descriptionText.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            descriptionText.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            parent.bottomAnchor.constraint(equalToSystemSpacingBelow: descriptionText.lastBaselineAnchor, multiplier: 1)
        ])
    }
    
    // MARK: - Binding
    
    func bind(movie: Movie) {
        title.text = movie.title
        descriptionText.text = movie.overview
    }
}
