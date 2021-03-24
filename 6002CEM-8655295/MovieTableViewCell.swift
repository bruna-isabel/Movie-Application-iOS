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
    @IBOutlet var movieGenre: UILabel!
    @IBOutlet var moviePoster: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
