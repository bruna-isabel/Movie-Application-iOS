//
//  IndividualMoviePageViewController.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 26/03/2021.
//

import UIKit

class IndividualMovieVC: UIViewController {
    
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieSynopsis: UILabel!
    @IBOutlet var movieRating: UILabel!
    @IBOutlet var movieReleaseYear: UILabel!
    
    var movie: Movie!
    private var urlStringImage: String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(movie!)
        movieTitle.text = movie.title
        movieRating.text = "Rating: \(String(movie.rating!))"
        movieSynopsis.text = movie.synopsis
        movieReleaseYear.text = movie.release_year
        
        let imageString = String(movie.image!)
        urlStringImage = "https://image.tmdb.org/t/p/w300" + imageString
        
        downloadImage(from: urlStringImage)
    }

    
        func downloadImage(from url: String) {
            guard let imageURL = URL(string: url) else { return }

                // just not to cause a deadlock in UI!
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else { return }

                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.movieImage.image = image
                }
            }
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
