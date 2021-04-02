//
//  MovieTableViewCell.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 23/03/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieSynopsis: UILabel!
    @IBOutlet var movieRating: UILabel!
    @IBOutlet var movieReleaseYear: UILabel!
    @IBOutlet var movieImage: UIImageView!
    
    private var urlStringImage: String = " "
    
    //Put Movie Values
    func setCellValues(_ movie:Movie) {
        updateUIViews(title: movie.title, release_year: movie.release_year, rating: movie.rating, synopsis: movie.synopsis, image: movie.image)
    }

    private func updateUIViews(title: String?, release_year: String?, rating: Double?, synopsis: String?, image: String?) {
        
        self.movieTitle.text = title
        self.movieSynopsis.text = synopsis
        self.movieRating.text = String(rating!)
        self.movieReleaseYear.text = release_year
        
        //Each Movie has a diferent path for image. Variable is unwrapped.
        let imageString = image!
        urlStringImage = "https://image.tmdb.org/t/p/w300" + imageString
        
        //In case there's no image
        guard let imageURL = URL(string: urlStringImage) else {
            self.movieImage.image = UIImage(named: "noImage")
            return
        }
        //Clears out image before we download new one
        self.movieImage.image = nil
        //Calls function that handles image request
        getImageURL(url: imageURL)
    }
    
    //Get Image URL from jSON file
    func getImageURL(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    print(data)
                    self.movieImage.image = image
                }
            }
        }.resume()
    }
}
