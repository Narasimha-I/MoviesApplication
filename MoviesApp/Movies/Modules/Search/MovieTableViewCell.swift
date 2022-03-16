//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by MAC on 25/01/22.
//

import UIKit
import Kingfisher

protocol MovieCellDelegate: AnyObject {
    func favAction(isSelected:Bool, index:Int)
}

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var overViewLbl: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var reviewsCountLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    weak var delegate:MovieCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        titleLbl.text = ""
        overViewLbl.text = ""
        reviewsCountLbl.text = ""
        favButton.setImage(UIImage(named:"favourite_unselected"), for: .normal)

    }

    func setData(photo:PhotoDetail, index:Int) {
        titleLbl.text = photo.title
        posterImageView.kf.setImage(with:URL(string: photo.url))

    }
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let imageName = sender.isSelected ? "favourite_selected" : "favourite_unselected"
        sender.setImage(UIImage(named: imageName), for: .normal)
        
        delegate?.favAction(isSelected:sender.isSelected, index: sender.tag)
    }
    
}
