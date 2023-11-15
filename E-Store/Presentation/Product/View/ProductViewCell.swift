//
//  ProductViewCell.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 03/11/23.
//

import UIKit

protocol ProductViewCellDelegate: AnyObject {
    func ProductViewCellFavoriteButtonTapped(_ cell: ProductViewCell)
}

class ProductViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: ProductViewCellDelegate?
    
    @IBAction func FavoriteButtonTap(_ sender: Any) {
        delegate?.ProductViewCellFavoriteButtonTapped(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        thumbImageView.layer.cornerRadius = 4
        thumbImageView.layer.masksToBounds = true
    }
}
