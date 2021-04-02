//
//  ViewController.swift
//  TMDb
//
//  Created by Joshua Lamson on 2/19/21.
//

import UIKit

class MovieSearchViewController: UIViewController {

    var viewModel: MovieSearchViewModel?
    
    var movieData: [Movie] = []
    
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
    
    lazy var progress: UIActivityIndicatorView = {
        let it = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        it.style = UIActivityIndicatorView.Style.large
        it.color = UIColor.purple
        it.hidesWhenStopped = true
        
        return it
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutChildren()
        title = "Search"
        
        guard let viewModel = viewModel else {
            fatalError("viewModel (MovieSearchViewModel) not set")
        }
        
        viewModel.observeForLifetime(of: self) { [weak self] vc, viewState in
            self?.render(viewState)
        }
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
        
        view.addSubview(progress)
        progress.center = view.center
        progress.bringSubviewToFront(view)
        progress.stopAnimating()
    }
    
    private func render(_ viewState: MovieSearchViewState) {
        switch(viewState) {
        case .Loading:
            progress.startAnimating()
        case .Success(movies: let movies):
            progress.stopAnimating()
            movieData = movies
            tableView.reloadData()
        case .Failure(error: let error):
            let alert = UIAlertController(
                title: "Error",
                message: error.localizedDescription,
                preferredStyle: UIAlertController.Style.alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            present(alert, animated: true)
        }
    }
}

// MARK: - Search Bar

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let safeQuery = searchBar.text {
            viewModel?.search(query: safeQuery)
        }
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
