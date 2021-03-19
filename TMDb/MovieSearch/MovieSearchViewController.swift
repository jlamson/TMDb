//
//  ViewController.swift
//  TMDb
//
//  Created by Joshua Lamson on 2/19/21.
//

import UIKit

class MovieSearchViewController: UIViewController {

    lazy var searchBar: UISearchBar = {
        let it = UISearchBar()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.delegate = self
        
        return it
    }()
    
    lazy var tableView: UITableView = {
        let it = UITableView()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.dataSource = self
        it.rowHeight = UITableView.automaticDimension
        it.estimatedRowHeight = 200
        it.register(MovieViewCell.self, forCellReuseIdentifier: MovieViewCell.identifier)
        
        return it
    }()
    
    let movieData: [Movie] = {
        var movies: [Movie] = []
        for i in 1...10 {
            movies.append(
                Movie(name: "name" + "\(i)",
                      desc: "\(i)" + ": Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dignissim enim sit amet venenatis urna. Sit amet luctus venenatis lectus magna fringilla urna porttitor.")
            )
        }
        return movies
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutChildren()
        
        tableView.reloadData()
    }
    
    private func layoutChildren() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

// MARK: - Search Bar

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let alert = UIAlertController()
        alert.message = searchBar.text
        alert.addAction(
            UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                
            })
        )
        self.present(alert, animated: true, completion: { })
    }
}

// MARK: - Table View

extension MovieSearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let convertView = tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as! MovieViewCell
        
        convertView.bind(movie: movieData[indexPath.row])
        
        return convertView
    }
}
