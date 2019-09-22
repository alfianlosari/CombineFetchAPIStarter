//
//  MovieListViewController.swift
//  CombineFetchAPI
//
//  Created by Alfian Losari on 22/09/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import Combine

fileprivate enum Section {
    case main
}

class MovieListViewController: UITableViewController {

    fileprivate var diffableDataSource: UITableViewDiffableDataSource<Section, Movie>!
    private var subscriptions = Set<AnyCancellable>()
    var movieAPI = MovieStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Combine X API Fetch"
        setupTableView()
        fetchMovies()
    }

    func fetchMovies() {
       // TODO: Implement Fetch Movies
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        diffableDataSource = UITableViewDiffableDataSource<Section, Movie>(tableView: tableView) { (tableView, indexPath, movie) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = movie.title
            return cell
        }
    }
    
    private func generateSnapshot(with movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func handleError(apiError: MovieStoreAPIError) {
        let alertController = UIAlertController(title: "Error", message: apiError.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}


fileprivate extension UIActivityIndicatorView {
    
    var combine_isAnimating: Bool  {
        set {
            if (newValue) {
                startAnimating()
            } else {
                stopAnimating()
            }
        }
        
        get {
            return isAnimating
        }
        
    }
    
    
    
}
