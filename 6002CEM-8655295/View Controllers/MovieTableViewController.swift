//
//  MovieTableViewController.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 18/03/2021.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    var movies = [Movie]()
    var API = MoviesAPI()
    var selectedIndexMovie = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    //reloads movies into table view
    private func loadMovies() {
        fetchMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
    
    func fetchMoviesData(completion: @escaping () -> ()) {
        
        API.fetchMovies { [weak self] (movie) in
            //in case it fails, handles error
            switch movie {
            case .success(let listOfMovies):
                self?.movies = listOfMovies.movies
                print(listOfMovies.movies[0])
                completion()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    //How many movies to put in initial page
    func rowsInSection(section: Int) -> Int {
        if movies.count != 0 {
            print(movies.count)
            return movies.count
        }
        return 0
    }
    
    //Cells in table
    func cellForRow (indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowsInSection(section: section)
    }
    
    //cell table view
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
         let row = cellForRow(indexPath: indexPath)
         cell.setCellValues(row)
         return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexMovie = indexPath.row
        performSegue(withIdentifier: "movieDetails", sender: self)
    }
    
    //Segue to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "movieDetails") {
            // pass data in here
            let individualViewController = segue.destination as! IndividualMovieVC
            individualViewController.movie = movies[selectedIndexMovie]
        }

            
        
    }
}
