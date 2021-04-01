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
    @IBOutlet var movieYear: UILabel!
    @IBOutlet var movieRating: UILabel!
    @IBOutlet var movieSynopsis: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movie)
        movieTitle.text = movie.title
        movieRating.text = "\(String(describing: movie.rating))"
        movieSynopsis.text = movie.synopsis
        movieYear.text = movie.release_year
        movieImage.image = UIImage(named: String(movie.image!))
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
